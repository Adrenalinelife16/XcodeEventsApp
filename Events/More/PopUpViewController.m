//
//  PopUpViewController.m
//  Adrenaline Life
//
//  Created by Michael Cather on 8/11/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import "PopUpViewController.h"


@interface PopUpViewController () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation PopUpViewController
@synthesize tblPopUp;


- (void)viewDidLoad {

     [super viewDidLoad];
    
    
    
    daysOfWeek = [[NSMutableArray alloc] initWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
      
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.tblPopUp reloadData];
    tblPopUp.allowsMultipleSelection = YES;
    tblPopUp.userInteractionEnabled = YES;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [daysOfWeek count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"DaysofWeek";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    cell.textLabel.text = [daysOfWeek objectAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismissPopup:(id)sender {
    
   
    [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:TRUE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:TRUE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:TRUE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:4]setEnabled:TRUE];
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
