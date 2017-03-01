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
#import "MMdbsupport.h"
#import "AboutViewController.h"

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

- (void)viewDidDisappear:(BOOL)animated;
{
   
    [self.navigationController popViewControllerAnimated:YES];

}


-(IBAction)btnLogoutPressed:(id)sender

{
    
        [self resetDefaults];
        [MMdbsupport MMExecuteSqlQuery:[NSString stringWithFormat:@"delete from ZFAVOURITEEVENTS where ZEVENT_ID = '%@'",self.eventObj.eventID]];
    
        NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
        
        NSLog(@"User ID after logout is %@", strUserID);
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Logout Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
        [self dismissModalStack];
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

-(void)dismissModalStack {
    UIViewController *vc = self.presentingViewController;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:NULL];
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
