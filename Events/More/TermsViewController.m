//
//  TermsViewController.m
//  Events
//
//  Created by Lamar Artare on 3/4/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController
@synthesize scrlVW;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
    txtVWContent.text = NSLocalizedString(@"CONTENT_TERMSCONDITIONS", @"CONTENT_TERMSCONDITIONS");
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrlVW setContentSize:CGSizeMake(100, 1800)];
}

@end
