//
//  DiscoverTableViewController.h
//  Events
//
//  Created by Michael Cather on 7/7/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventList.h"

@interface DiscoverTableViewController : UITableViewController


@property (strong, nonatomic) EventList *eventObjFav;

@property (nonatomic, retain) NSString *discoverText;

@end
