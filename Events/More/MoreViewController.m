//
//  MoreViewController.m
//  Events
//
//  Created by Souvick Ghosh on 2/25/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreDetailsTableViewController.h"
#import "LoginViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
{
    NSArray *mainTableData;
    NSArray *secondTableData;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mainTableData = [NSArray arrayWithObjects:@"Help Center", @"Terms & Conditions", @"Settings", @"Login/Register", nil];
    secondTableData = [NSArray arrayWithObjects:@"Help Center", @"Terms & Conditions", @"Settings", nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [mainTableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    static NSString *CellIdentifier = @"MoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }


    cell.textLabel.text = [mainTableData objectAtIndex:indexPath.row];

    return cell;

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"loginRegister"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *object = mainTableData[indexPath.row];
        [segue destinationViewController];
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"arrayDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        MoreDetailsTableViewController *destViewController = segue.destinationViewController;
//        destViewController.moreDetails = [mainTableData objectAtIndex:indexPath.row];
//        destViewController.title = destViewController.moreDetails;
//    
//    }
//    
//}
@end
