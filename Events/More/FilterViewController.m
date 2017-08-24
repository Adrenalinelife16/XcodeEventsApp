//
//  FilterViewController.m
//  Adrenaline Life
//
//  Created by Michael Cather on 8/11/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import "FilterViewController.h"
#import "ProgramViewController.h"


@interface FilterViewController () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation FilterViewController
@synthesize selectedCellText;
@synthesize tblPopup;


- (void)viewDidLoad {

     [super viewDidLoad];
    
    
    daysOfWeek = [[NSMutableArray alloc] initWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
      
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.tabBarController.tabBar setHidden:YES];
    
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    [self.navigationItem setTitle:@"Filter"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
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
    
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedCellText = cell.textLabel.text;
    
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismissFilter:(id)sender {
    
         [self performSegueWithIdentifier:@"filterDays" sender:sender];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"filterDays"]) {
        ProgramViewController *destinationView = [segue destinationViewController];
        NSIndexPath *selectedIndexPath = [self.tblPopup indexPathForSelectedRow];
        UITableViewCell *cell = [self.tblPopup cellForRowAtIndexPath:selectedIndexPath];
        destinationView.filterText = cell.textLabel.text;
      //  [destinationView filterProgramArray];

    }
}




@end
