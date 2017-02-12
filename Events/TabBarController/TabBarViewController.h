//
//  TabBarViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITabBar *tabBar;

-(void)changeTab:(int)index;

@end
