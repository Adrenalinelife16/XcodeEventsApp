//
//  AttendingViewController.m
//  Events
//
//  Created by Michael Cather on 6/26/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "AttendingViewController.h"

@interface AttendingViewController ()

@end

@implementation AttendingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Find Your Life";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Find Your Life";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented.png"];
     [self getMyTickets];
    self.navigationItem.hidesBackButton = YES;
}

#pragma mark - Button Clicked Function
- (IBAction)clickedMyAttending:(id)sender {
    [self.btnMyTickets setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyCalender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    [self getMyTickets];
    
    
    
    
}

- (IBAction)clickedMyFavourites:(id)sender {
    
    [DSBezelActivityView newActivityViewForView:self.view.window withLabel:@"Fetching favorites"];
    [self.btnMyTickets setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyCalender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    
    
}

- (IBAction)clickedMyCalender:(id)sender {
       
}



-(void)getMyTickets
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Attending event coming soon!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [av show];
    
    
    /*
     NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getNSUserDefaultValue:KUSERID],@"user_id",@"1",@"page",@"30",@"page_size", nil];
     
     [Utility GetDataForMethod:NSLocalizedString(@"GETUSERTICKETS_METHOD", @"GETUSERTICKETS_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id response){
     [DSBezelActivityView removeViewAnimated:YES];
     
     if ([response isKindOfClass:[NSDictionary class]]) {
     [Utility alertNotice:@"" withMSG:[response objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
     }
     else if([response isKindOfClass:[NSArray class]]){
     [Utility alertNotice:@"" withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
     }
     [self.tblMainTable reloadData];
     
     }WithFailure:^(NSString *error){
     [DSBezelActivityView removeViewAnimated:YES];
     NSLog(@"%@",error);
     }];
     */
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
