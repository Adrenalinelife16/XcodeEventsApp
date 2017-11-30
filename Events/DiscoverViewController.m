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
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

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
    self.navigationItem.title = @"Discover Events";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = YES;

}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrlVW setContentSize:CGSizeMake(100, 1950)]; //Change height here when adding more categories to discover page
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonZero:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
               customAttributes:@{@"Category" : @"Soccer"}];
    
    
    
}

-(IBAction)buttonOne:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Kickball"}];
    
    
}

-(IBAction)buttonTwo:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Football"}];
}

-(IBAction)buttonThree:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Basketball"}];
    
}

-(IBAction)buttonFour:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Yoga"}];
    
}

-(IBAction)buttonFive:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Fitness"}];
    
}

-(IBAction)buttonSix:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Golf"}];
    
}

-(IBAction)buttonSeven:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Fishing"}];
}

-(IBAction)buttonEight:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Tennis"}];
    
}

-(IBAction)buttonNine:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Riding"}];
}

-(IBAction)buttonTen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Baseball"}];
}

-(IBAction)buttonEleven:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Billiards"}];
}

-(IBAction)buttonTwelve:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Running"}];
}

-(IBAction)buttonThirteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Camping"}];
    
}

-(IBAction)buttonFourteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Water"}];
    
    
}

-(IBAction)buttonFifteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Climbing"}];
    
    
}

-(IBAction)buttonSixteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Disc"}];
}

-(IBAction)buttonSeventeen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Bowling"}];
    
    
}

-(IBAction)buttonEighteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Table"}];
}

-(IBAction)buttonNineteen:(id)sender {
    
    
    UIButton *btn= (UIButton *)sender;
    [self performSegueWithIdentifier:@"discoverEvent" sender:sender];
    
    [Answers logCustomEventWithName:@"Discover Category"
                   customAttributes:@{@"Category" : @"Lacrosse"}];
    
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
