//
//  CategoryTableViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.



#import "CategoryTableViewController.h"
#import "CreateEventViewController.h"

@interface CategoryTableViewController ()

@end

@implementation CategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
    
    // Created Category Array

    categoryArray = [[NSMutableArray alloc] initWithObjects:@"Baseball/Softball", @"Basketball", @"Billiards", @"Bowling", @"Camping", @"Climbing", @"Disc Games", @"Fishing", @"Fitness", @"Football", @"Golf", @"Lacrosse",@"Other",@"Riding",@"Running/Hiking",@"Soccer",@"Table Games",@"Tennis",@"Water Games",@"Yoga",@"Kickball", nil];
    
    //Sort Array
    
    [categoryArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Choose a Category";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [categoryArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Category";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    cell.textLabel.text = [categoryArray objectAtIndex:indexPath.row];
   
    return cell;

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CreateEvent"]) {
        CreateEventViewController *destinationView = [segue destinationViewController];
        UITableViewCell *selectedCell = (UITableViewCell *)sender;
        destinationView.titleText = selectedCell.textLabel.text;
    }
}

@end
