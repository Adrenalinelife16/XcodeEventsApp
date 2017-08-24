//
//  FilterViewController.h
//  Adrenaline Life
//
//  Created by Michael Cather on 8/11/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController
{
    NSMutableArray *daysOfWeek;
    NSMutableArray *storeDaysWeek;
}

@property (nonatomic, copy) NSString* selectedCellText;

@property (strong, nonatomic) IBOutlet UITableView *tblPopup;


-(IBAction)dismissFilter:(id)sender;


@end
