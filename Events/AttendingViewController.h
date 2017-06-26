//
//  AttendingViewController.h
//  Events
//
//  Created by Michael Cather on 6/26/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imgSegmentBar;
@property (strong, nonatomic) IBOutlet UIButton *btnMyTickets;
@property (strong, nonatomic) IBOutlet UIButton *btnMyFavourites;
@property (strong, nonatomic) IBOutlet UIButton *btnMyCalender;

- (IBAction)clickedMyAttending:(id)sender;

- (IBAction)clickedMyFavourites:(id)sender;

- (IBAction)clickedMyCalender:(id)sender;

@end
