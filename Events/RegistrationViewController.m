//
//  RegistrationViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
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
    [self bottomBorder];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
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

-(void)CreateUser {
    
    NSMutableString *rawSTr = [NSMutableString stringWithFormat:@"first_name=%@&last_name=%@&email=%@&username=%@&pass=%@", txtFirstName.text, txtLastName.text, txtEmail.text, txtUsername.text, txtPassword.text];
    
    NSData *data = [rawSTr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *URL = [NSURL URLWithString:@"http://www.adrenalinelife.org/Adrenaline_Custom/newUser.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSError *error;
    NSMutableArray *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    NSLog(@"Dictionary Results %@", dictionary);
    
    NSMutableDictionary *object = [dictionary objectAtIndex:0];
    NSMutableArray *number = [object objectForKey:@"Error"];
    NSLog(@"%@", number);
    
    NSNumber *errorCode = number;
    
    // Check Username and Email duplicates-------------------------------------------------------------------------------
    
    
    if ([errorCode intValue] == 0) {
        NSLog(@"Username Doesn't Exist");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Account Created" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    }
    
    if ([errorCode intValue] == 1) {
        NSLog(@"Username Already Exist");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Username and Email Already Exist!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}


#pragma mark - Text Field Delegates
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
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
        message     =   @"Please enter first name!";
    }
    else if (!([self.txtLastName.text length]>0)) {
        message     =   @"Please enter last name!";
    }
    else if (!([self.txtUsername.text length]>0)) {
        message     =   @"Please enter username!";
    }
    else if (!([self.txtEmail.text length]>0)) {
        message     =   @"Please enter email!";
    }
    else if (!([self.txtPassword.text length]>0)) {
        message     =   @"Please enter password!";
    }
    else if (![self validateEmail:txtEmail.text]){
        message     =   @"Please enter valid email!";
    }
    else
    {
        [self CheckPasswordMatch];
    }
 
    if ([message length]>0) {
        [Utility alertNotice:APPNAME withMSG:message cancleButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }
    return YES;
}


// Hide keyboard when touch background

-(IBAction)backgroundTouched:(id)sender
{
    [txtFirstName resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtUsername resignFirstResponder];
    [txtPassword resignFirstResponder];
    [txtConfirmPassword resignFirstResponder];
}

//Hide keyboard when touch return

-(IBAction)textfieldReturn:(id)sender
{
    [sender resignFirstResponder];
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
   //     [self.tabBarController setSelectedIndex:0];
   //     [self.navigationController popViewControllerAnimated:NO];
        
    }
}

-(void)bottomBorder
{
    CALayer *BBFirstName = [CALayer layer];
    BBFirstName.frame = CGRectMake(0.0f, self.txtFirstName.frame.size.height - 1, self.txtFirstName.frame.size.width, 1.0f);
    BBFirstName.backgroundColor = [UIColor grayColor].CGColor;
    [self.txtFirstName.layer addSublayer:BBFirstName];
    
    CALayer *BBLastName = [CALayer layer];
    BBLastName.frame = CGRectMake(0.0f, self.txtLastName.frame.size.height - 1, self.txtLastName.frame.size.width, 1.0f);
    BBLastName.backgroundColor = [UIColor grayColor].CGColor;
    [self.txtLastName.layer addSublayer:BBLastName];
    
    CALayer *BBUserName = [CALayer layer];
    BBUserName.frame = CGRectMake(0.0f, self.txtUsername.frame.size.height - 1, self.txtUsername.frame.size.width, 1.0f);
    BBUserName.backgroundColor = [UIColor grayColor].CGColor;
    [self.txtUsername.layer addSublayer:BBUserName];
    
    CALayer *BBEmail = [CALayer layer];
    BBEmail.frame = CGRectMake(0.0f, self.txtEmail.frame.size.height - 1, self.txtEmail.frame.size.width, 1.0f);
    BBEmail.backgroundColor = [UIColor grayColor].CGColor;
    [self.txtEmail.layer addSublayer:BBEmail];
    
    CALayer *BBPassword = [CALayer layer];
    BBPassword.frame = CGRectMake(0.0f, self.txtPassword.frame.size.height - 1, self.txtPassword.frame.size.width, 1.0f);
    BBPassword.backgroundColor = [UIColor grayColor].CGColor;
    [self.txtPassword.layer addSublayer:BBPassword];
    
    CALayer *BBConPassword = [CALayer layer];
    BBConPassword.frame = CGRectMake(0.0f, self.txtConfirmPassword.frame.size.height - 1, self.txtConfirmPassword.frame.size.width, 1.0f);
    BBConPassword.backgroundColor = [UIColor grayColor].CGColor;
    [self.txtConfirmPassword.layer addSublayer:BBConPassword];
    
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
