//
//  MoreViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "MoreViewController.h"
#import "LoginViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController


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
    
    moreArray = [[NSMutableArray alloc] initWithObjects:@"Help Center", @"Terms & Conditions", @"Settings", @"Login", nil];
   // [moreArray removeObjectAtIndex:3];
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
    
    return [moreArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       static NSString *simpleTableIdentifier = @"MoreCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
   
    
    cell.textLabel.text = [moreArray objectAtIndex:indexPath.row];
    return cell;
    
}


// Needed to call new method "Did select row"

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"helpCenter" sender:self];
        break;
            
        case 1:
            [self performSegueWithIdentifier:@"termsCondition" sender:self];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"pushSettings" sender:self];
            break;
            
        case 3:
            [self performSegueWithIdentifier:@"loginRegister" sender:self];
            break;
            
            
        default: break;
    }
    
    
}


#pragma mark - Navigation
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"loginRegister"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LoginViewController *destViewController = [segue destinationViewController];
        destViewController.getDetails = [moreArray objectAtIndex:indexPath.row];
        
    }

    
}

*/
@end
