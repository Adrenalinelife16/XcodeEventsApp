//
//  CalendarViewController.h
//  Events
//
//  Created by Michael Cather on 6/28/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventList.h"
#import "LoginViewController.h"

@interface CalendarViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tblMainTable;//used for mytickets and my favorites



@property (strong, nonatomic) NSMutableArray *arrDetails;
@property (strong, nonatomic) IBOutlet UIButton *btnNotifiction;
@property (strong, nonatomic) IBOutlet UIImageView *imgSegmentBar;
@property (strong, nonatomic) IBOutlet UIButton *btnMyTickets;
@property (strong, nonatomic) IBOutlet UIButton *btnMyFavourites;
@property (strong, nonatomic) IBOutlet UIButton *btnMyCalender;
@property (strong, nonatomic) IBOutlet UIScrollView *calendarView;
@property (strong, nonatomic) EventList *eventObjFav;


@property (nonatomic,retain) NSMutableData *receivedData;
@property (strong, nonatomic) NSMutableArray *arrayFavEvent;


@property (nonatomic, retain) NSDate *currentMonth;
@property (nonatomic, retain, getter = selectedDate) NSDate *selectedDate;

- (IBAction)clickedMyAttending:(id)sender;

- (IBAction)clickedMyFavourites:(id)sender;

- (IBAction)clickedMyCalender:(id)sender;


@end
