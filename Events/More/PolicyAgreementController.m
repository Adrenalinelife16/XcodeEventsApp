
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved. Copyright © 2017 Teknowledge Software. All rights reserved.



#import "PolicyAgreementController.h"

@interface PolicyAgreementController ()

@end

@implementation PolicyAgreementController
@synthesize scrlVW;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
    txtVWContent.text = NSLocalizedString(@"CONTENT_PRIVACY", @"CONTENT_PRIVACY");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scrlVW setContentSize:CGSizeMake(150, 1000)];
}

@end
