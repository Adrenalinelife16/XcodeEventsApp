//
//  TableCellTableViewController.h
//  Events
//
//  Created by Michael Cather on 5/15/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@import UIKit;

@class EventList;

extern NSString *const kCellIdentifier;

@interface TableCellTableViewController : UITableViewController <UITableViewDataSource, UITextViewDelegate, UISearchBarDelegate>

- (void)configureCell:(UITableViewCell *)cell forProduct:(EventList *)product;


@end
