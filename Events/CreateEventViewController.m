//
//  CreateEventViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "CreateEventViewController.h"
#import "FeedDetailViewController.h"

@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BetaPageText.text = NSLocalizedString(@"CONTENT_BETAPAGE", @"CONTENT_BETAPAGE");
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)btnCreateEvent:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.adrenalinelife.org/create-event/"]];
    
}

-(IBAction)btnDiscoverCategories:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.adrenalinelife.org/browse-by-category/"]];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FeedDetailViewController *feedDetailVwController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"CreateWebView"]) {
        feedDetailVwController.strFeedURL   =   [NSString stringWithFormat:@"http://www.adrenalinelife.org/create-event/"];
    }
    
}


@end
