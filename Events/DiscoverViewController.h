//
//  DiscoverViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIScrollView *scrlVW;
@property (strong, nonatomic) IBOutlet UITableView *tblDiscResults; // Displaying Discover results

-(IBAction)btnDiscoverCategories:(id)sender;


@end
