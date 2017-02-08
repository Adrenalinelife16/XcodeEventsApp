//
//  MoreDetailsTableViewController.m
//  Events
//
//  Created by Michael Cather on 2/7/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "MoreDetailsTableViewController.h"

@interface MoreDetailsTableViewController ()

@end

@implementation MoreDetailsTableViewController {
    
    NSArray *settings;
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
    
    settings = [NSArray arrayWithObjects:@"Push Notifications", @"Logout", nil];

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

    if ([_moreDetails isEqualToString:@"Settings"]) {
        return [settings count];
    }
    
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MoreCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([_moreDetails isEqualToString:@"Settings"])
    {
        cell.textLabel.text = [settings objectAtIndex:indexPath.row];
    }
    
    return cell;
}


@end
