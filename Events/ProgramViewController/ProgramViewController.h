//
//  ProgramViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramViewController : UITableViewController <UIPopoverControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>


-(IBAction)createEvent:(id)sender;
-(IBAction)searchButtonPressed:(id)sender;



@end
