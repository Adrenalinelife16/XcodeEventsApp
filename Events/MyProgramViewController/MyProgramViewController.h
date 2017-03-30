//
//  MyProgramViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventList.h"
#import "LoginViewController.h"

@interface MyProgramViewController : UIViewController<loginViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblMainTable;//used for mytickets and my favorites



@property (strong, nonatomic)NSMutableArray *arrDetails;
@property (strong, nonatomic) IBOutlet UIButton *btnNotifiction;
@property (strong, nonatomic) IBOutlet UIImageView *imgSegmentBar;
@property (strong, nonatomic) IBOutlet UIButton *btnMyTickets;
@property (strong, nonatomic) IBOutlet UIButton *btnMyFavourites;
@property (strong, nonatomic) IBOutlet UIButton *btnMyCalender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewMain;
@property (strong, nonatomic) EventList *eventObj;

- (IBAction)clickedMyTickets:(id)sender;

- (IBAction)clickedMyFavourites:(id)sender;

- (IBAction)clickedMyCalender:(id)sender;
@end
