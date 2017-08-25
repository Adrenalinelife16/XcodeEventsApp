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
    
    _butZero.accessibilityLabel=@"Soccer";
    _butOne.accessibilityLabel=@"Kickball";
    _butTwo.accessibilityLabel=@"Football";
    _butThree.accessibilityLabel=@"Basketball";
    _butFour.accessibilityLabel=@"Yoga";
    _butFive.accessibilityLabel=@"Fitness";
    _butSix.accessibilityLabel=@"Golf";
    _butSeven.accessibilityLabel=@"Fishing";
    _butEight.accessibilityLabel=@"Tennis";
    _butNine.accessibilityLabel=@"Riding";
    _butTen.accessibilityLabel=@"Baseball";
    _butEleven.accessibilityLabel=@"Billiards";
    _butTwelve.accessibilityLabel=@"Running";
    _butThirteen.accessibilityLabel=@"Camping";
    _butFourteen.accessibilityLabel=@"Water";
    _butFifteen.accessibilityLabel=@"Climbing";
    _butSixteen.accessibilityLabel=@"Disc";
    _butSeventeen.accessibilityLabel=@"Bowling";  
    _butEighteen.accessibilityLabel=@"Table";
    _butNineteen.accessibilityLabel=@"Lacrosse";
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Discover";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = YES;

}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrlVW setContentSize:CGSizeMake(100, 1835)]; //Change height here when adding more categories to discover page
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonZero:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonOne:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonTwo:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonThree:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonFour:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonFive:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonSix:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonSeven:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonEight:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonNine:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonTen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonEleven:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonTwelve:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonThirteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonFourteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonFifteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonSixteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonSeventeen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonEighteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    
}

-(IBAction)buttonNineteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
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
