//
//  LogoutViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "LogoutViewController.h"
#import "ProgramViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "Utility.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)btnLogoutPressed:(id)sender

{
    
        [self resetDefaults];
        NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    
//    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"])  {
  //      NSLog(@"User ID is %@", strUserID);
        
    
        
        NSLog(@"User ID after logout is %@", strUserID);
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Logout Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av setTag:99];
        [av show];
        [self.tabBarController setSelectedIndex:0];

            }

- (void)resetDefaults {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}




  //     [[NSUserDefaults standardUserDefaults] removeObjectForKey:strUserID];
 /*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
