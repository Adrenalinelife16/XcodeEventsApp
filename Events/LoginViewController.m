//
//  LoginViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "LoginViewController.h"
#import "ProgramViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize delegate;
@synthesize txtEmail, txtPassword, txtUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self bottomBorder];
   
    self.title = @"Login";
 //   [self InitializeNavigationBatItem];
}


- (void)viewWillAppear:(BOOL)animated;
{
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnCancelPressed
{
    if (delegate) {
        [delegate dismissLoginView];
    }
}

-(void)bottomBorder
{
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.txtUsername.frame.size.height - 1, self.txtUsername.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
    [self.txtUsername.layer addSublayer:bottomBorder];
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, self.txtPassword.frame.size.height - 1, self.txtPassword.frame.size.width, 1.0f);
    topBorder.backgroundColor = [UIColor grayColor].CGColor;
    [self.txtPassword.layer addSublayer:topBorder];

}

-(IBAction)forgotPasswordPressed:(id)sender
{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.adrenalinelife.org/resetpass/"]];

}

-(void)dismissRegistrationView
{
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self dismissViewControllerAnimated:NO completion:nil]; }
                    completion:nil];
}

#pragma mark - login button tap
-(IBAction)btnLoginPressed:(id)sender
{
  //  [txtEmail resignFirstResponder];
 //   [txtPassword resignFirstResponder];
    
    if ([self isValid]) {
        [DSBezelActivityView newActivityViewForView:self.view.window];
        NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:self.txtEmail.text,@"email",self.txtUsername.text,@"username",self.txtPassword.text,@"pwd", nil];
        
        [Utility GetDataForMethod:NSLocalizedString(@"LOGIN_METHOD", @"LOGIN_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id response){
            
            [DSBezelActivityView removeViewAnimated:YES];
            if ([response isKindOfClass:[NSArray class]]) {
                
                if ([[[response objectAtIndex:0] objectForKey:@"status"] intValue] == 0) {
                    [Utility alertNotice:@"" withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                }
                else{
                    [Utility setNSUserDefaultValueForString:[[response objectAtIndex:0] objectForKey:@"user_id"] strKey:KUSERID];
                    
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Login Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av setTag:99];
                    [av show];
                }
            }
            else if ([response isKindOfClass:[NSDictionary class]]){
                if ([[response objectForKey:@"status"] intValue] == 0) {
                    [Utility alertNotice:@"" withMSG:[response objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                }
                else{
                    [Utility setNSUserDefaultValueForString:[response objectForKey:@"user_id"] strKey:KUSERID];
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Login Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av setTag:99];
                    [av show];
                    // Perform Segue Here to Main Program View
                    
                    
                    [self.tabBarController setSelectedIndex:0];
                    [self.navigationController popViewControllerAnimated:NO];
                    NSLog(@"User ID logged in %@", dictOfParameters);
                
                    
                    }
                
            }
            
        }WithFailure:^(NSString *error){
            NSLog(@"%@",error);
            [DSBezelActivityView removeViewAnimated:YES];
        }];
    }
}
#pragma mark - Hide Keyboard
// Hide keyboard when touch background

-(IBAction)backgroundTouched:(id)sender
{
    [txtEmail resignFirstResponder];
    [txtUsername resignFirstResponder];
    [txtPassword resignFirstResponder];
   
}

//Hide keyboard when touch return

-(IBAction)textfieldReturn:(id)sender
{
    [sender resignFirstResponder];
}



#pragma mark - Check Validations for login
-(BOOL)isValid
{
    NSString *message   =   @"";
    if (!([txtEmail.text length]>0)) {
        message =   @"Please enter Username or Email";
    }
    else if (!([txtPassword.text length]>0)){
        message =   @"Please enter password";
    }
    /*
    else if (![self validateEmail:txtEmail.text]){
        message =   @"Please enter valid Username or Email";
    }
    */
    if ([message length]>0) {
        [Utility alertNotice:APPNAME withMSG:message cancleButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }
    return YES;
}


#pragma mark - Alert View Delegates
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        if (delegate) {
            [delegate dismissLoginView];
        }
    }
}
@end
