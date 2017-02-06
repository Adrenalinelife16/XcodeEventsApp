//
//  MyProgramViewController.h
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
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

- (IBAction)clickedMyTickets:(id)sender;

- (IBAction)clickedMyFavourites:(id)sender;

- (IBAction)clickedMyCalender:(id)sender;
@end
