//
//  PolicyViewController.m
//  Events
//
//  Created by Michael Cather on 5/11/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "PolicyViewController.h"

@interface PolicyViewController ()

@end

@implementation PolicyViewController
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
    policyTextView.text = NSLocalizedString(@"CONTENT_PRIVACY", "CONTENT_PRIVACY");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrollView setContentSize:CGSizeMake(100, 5000)];
}


@end
