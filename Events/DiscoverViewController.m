//
//  DiscoverViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "DiscoverViewController.h"
#import "FeedDetailViewController.h"
#import "DiscoverTableViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController
@synthesize scrlVW;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _soccer.accessibilityLabel=@"Soccer";
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Discover";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrlVW setContentSize:CGSizeMake(100, 650)]; //Change height here when adding more categories to discover page
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)soccerPressed:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    NSLog(@"Button String = %@",btn.accessibilityLabel);
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}


#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"discoverEvent"]) {
        DiscoverTableViewController *destinationView = [segue destinationViewController];
        NSString *tagIndex = [(UIButton *)sender accessibilityLabel];
        destinationView.discoverText = tagIndex;
    }
    
}

@end
