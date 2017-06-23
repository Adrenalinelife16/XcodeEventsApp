//
//  DiscoverViewController.h
//  Events
//
//  Created by Lamar Artare on 2/27/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIScrollView *scrlVW;
@property (strong, nonatomic) IBOutlet UITableView *tblDiscResults; // Displaying Discover results

-(IBAction)btnDiscoverCategories:(id)sender;


@end
