//
//  TabBarCenterIcon.m
//  Events
//
//  Created by Michael Cather on 3/14/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "TabBarCenterIcon.h"

@interface TabBarCenterIcon ()

@end

@implementation TabBarCenterIcon

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL *stop) {
        vc.tabBarItem.title = nil;
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
