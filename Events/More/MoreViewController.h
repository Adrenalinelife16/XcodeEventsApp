//
//  MoreViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UITableViewController <UIActionSheetDelegate>
{
    NSMutableArray *moreArray;
    UIActionSheet *logoutSheet;
}



@end
