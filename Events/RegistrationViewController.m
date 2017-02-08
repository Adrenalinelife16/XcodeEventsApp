//
//  RegistrationViewController.m
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "RegistrationViewController.h"
#import "XMLReader.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize delegate;
@synthesize scrlView;
@synthesize countryArray, countryName, countryCode;
@synthesize txtFirstName, txtLastName, txtUsername, txtEmail, txtPassword, txtConfirmPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma View Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Registration";
    
 //   [self InitializeNavigationBarItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialize Navigation Bar Item
/*
-(void)InitializeNavigationBarItem
{
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnCancel setFrame:CGRectMake(0, 7, 80, 30)];
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancelPressed)
        forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *leftBarBtn =[[UIBarButtonItem alloc] initWithCustomView:btnCancel];
    self.navigationItem.leftBarButtonItems  =       [[NSArray alloc] initWithObjects:leftBarBtn, nil];
    
  //  [self addDoneButtonOnNumericKeyboard];
}
*/
/**
 *  call delegate method through cancel button when user press cancel button instead of register
 */
-(void)btnCancelPressed
{
    if (delegate) {
        [delegate dismissRegistrationView];
    }
}

#pragma mark - Register button Pressed
-(IBAction)btnRegisterPressed:(id)sender{
    
    [self IsValid];
}

-(void)CreateUser
    
    {
       [self hideKeyboards];
     {
         
        NSString *Fname = txtFirstName.text;
        NSString *Lname = txtLastName.text;
        NSString *FirstLast = [NSString stringWithFormat:@" %@ %@", Fname, Lname];
         
        NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:FirstLast,@"name",self.txtEmail.text,@"email",self.txtPassword.text,@"pwd", nil];
        
        [Utility GetDataForMethod:NSLocalizedString(@"REGISTER_METHOD", @"REGISTER_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id response){
            
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[response objectForKey:@"message"] isEqualToString:@"Sorry, that username already exists!"]) {
                    [Utility alertNotice:APPNAME withMSG:[response objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                }
                else{
                    [Utility setNSUserDefaultValueForString:[response objectForKey:@"user_id"] strKey:KUSERID];
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:[response objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av setTag:99];
                    [av show];
                }
            }
            else if ([response isKindOfClass:[NSArray class]]) {
                
                if ([[[response objectAtIndex:0] objectForKey:@"message"] isEqualToString:@"Sorry, that username already exists!"]) {
                    [Utility alertNotice:APPNAME withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                }
                else{
                    [Utility setNSUserDefaultValueForString:[[response objectAtIndex:0] objectForKey:@"user_id"] strKey:KUSERID];
                    
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:[[response objectAtIndex:0] objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av setTag:99];
                    [av show];
                }
            }
            [DSBezelActivityView removeViewAnimated:YES];
            
        }WithFailure:^(NSString *error){
            [DSBezelActivityView removeViewAnimated:YES];
            NSLog(@"%@",error);
        }];
    }
}



#pragma Done Button on Numeric Keyboard
/**
 *  To add numeric keyboard and done toolbar on keyboad
 */
/*
-(void)addDoneButtonOnNumericKeyboard
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    txtFirstName.inputAccessoryView = numberToolbar;
    txtLastName.inputAccessoryView = numberToolbar;
    txtUsername.inputAccessoryView = numberToolbar;
    txtEmail.inputAccessoryView = numberToolbar;
    txtPassword.inputAccessoryView = numberToolbar;
}
*/
-(void)doneWithNumberPad
{
    [self hideKeyboards];
}

#pragma mark - Text Field Delegates
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyDone)
    {
        [textField resignFirstResponder];
    }
    else
    {
        UIResponder *nextResponder = [textField.superview viewWithTag:textField.tag+1];
            
        if (nextResponder){
            [nextResponder becomeFirstResponder];
        }
    }
    return NO;
}

#pragma mark - Check registration Field validations
-(BOOL)IsValid
{
    NSString *message   =   @"";
    
    if (!([self.txtFirstName.text length]>0)) {
        message     =   @"Please enter First Name";
    }
    else if (!([self.txtLastName.text length]>0)) {
        message     =   @"Please enter Last Name";
    }
    else if (!([self.txtUsername.text length]>0)) {
        message     =   @"Please enter Username";
    }
    else if (!([self.txtEmail.text length]>0)) {
        message     =   @"Please enter Email";
    }
    else if (!([self.txtPassword.text length]>0)) {
        message     =   @"Please enter Password";
    }
    else if (![self validateEmail:txtEmail.text]){
        message     =   @"Please enter valid Email";
    }
    else
    {
        [self CheckPasswordMatch];
    }
    
    
    if ([message length]>0) {
        [Utility alertNotice:@"" withMSG:message cancleButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }
    return YES;
}

/**
 *  Hide Text Fields keyboards
 */
-(void)hideKeyboards
{
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtUsername resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtPassword resignFirstResponder];
}

#pragma mark - email validation
-(BOOL)validateEmail:(NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark - confirm password
-(void)CheckPasswordMatch
{
    if (![txtPassword.text isEqualToString:txtConfirmPassword.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Passwords don't match!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
            [self CreateUser];
            [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"Processing..."];
            [self performSegueWithIdentifier:(@"toProgram") sender:(self)];
            // Perform segue code here to main events feed
    }
}


#pragma phone Number Validation
-(BOOL)IsPhoneNumberValid:(NSString *)phoneNumber
{
    NSCharacterSet *charcter =[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered;
    filtered = [[phoneNumber componentsSeparatedByCharactersInSet:charcter] componentsJoinedByString:@""];
    return [phoneNumber isEqualToString:filtered];
}

#pragma mark - Alert View Delegates
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        if (delegate) {
            [delegate dismissRegistrationView];
        }
    }
}

@end
