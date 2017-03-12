//
//  MoreViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "MoreViewController.h"
#import "LoginViewController.h"
#import "MoreCustomCell.h"


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
     self.navigationItem.title = @"More";
    
    // @"Settings"
    moreArray = [[NSMutableArray alloc] initWithObjects:@"Policy Agreement", @"Terms & Conditions", @"About Us", nil];
    [self checkLogin];

    
    }

- (void)viewWillAppear:(BOOL)animated;
{
    [self viewDidLoad];
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Check login for MyFavorite and MyTickets
-(void)checkLogin
{
    
    NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"])  {
        NSLog(@"User ID is %@", strUserID);
        [moreArray addObject:@"Logout"];

    }
    else
    {
        [moreArray addObject:@"Login"];
    }
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if(indexPath.row==0)
    {
        [self performSegueWithIdentifier:@"helpCenter" sender:self];
    }
    else if(indexPath.row==1)
    {
        [self performSegueWithIdentifier:@"termsCondition" sender:self];
    }
    else if(indexPath.row==2)
    {
        [self performSegueWithIdentifier:@"aboutUs" sender:self];
    }

    else if(indexPath.row==3)
    {
        
        NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
        if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"])
        
            [self logoutSheet];
        else
        {
            [self performSegueWithIdentifier:@"loginRegister" sender:self];
        }
       
    }
}

- (void)logoutSheet
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Are you sure you want to logout?"
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action)
        {
            [self resetDefaults];
            
            NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
            
            NSLog(@"User ID after logout is %@", strUserID);
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Logout Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [av show];
            [self dismissModalStack];
            [self.tabBarController setSelectedIndex:0];

            
            
        }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action)
        {
         [self.tableView reloadData];
        }];
    
    [alert addAction:logout];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
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
