//
//  TableCellTableViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@import UIKit;

@class EventList;

extern NSString *const kCellIdentifier;

@interface TableCellTableViewController : UITableViewController <UITableViewDataSource, UITextViewDelegate, UISearchBarDelegate>

- (void)configureCell:(UITableViewCell *)cell forProduct:(EventList *)product;


@end
