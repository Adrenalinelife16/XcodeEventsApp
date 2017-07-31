//
//  ReviewCreateEventViewController.h
//  Adrenaline Life
//
//  Created by Michael Cather on 7/25/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateEventViewController.h"

@interface ReviewCreateEventViewController : UIViewController
{
    UIDatePicker *datePicker;
    
}


// Fields for event submit
@property (nonatomic,retain) IBOutlet NSString *strEventName;
@property (nonatomic,retain) IBOutlet NSString *strCategory;
@property (nonatomic,retain) IBOutlet NSString *strStartDate;
@property (nonatomic,retain) IBOutlet NSString *strEndDate;
@property (nonatomic,retain) IBOutlet NSString *strStartTime;
@property (nonatomic,retain) IBOutlet NSString *strEndTime;
@property (nonatomic,retain) IBOutlet NSString *strLocationName;
@property (nonatomic,retain) IBOutlet NSString *strAddress;
@property (nonatomic,retain) IBOutlet NSString *strCity;
@property (nonatomic,retain) IBOutlet NSString *strState;
@property (nonatomic,retain) IBOutlet NSString *strZipCode;
@property (nonatomic,retain) IBOutlet NSString *userDetailView;
@property (nonatomic,retain) IBOutlet UIImage *userImageView;


// Labels view

@property (strong, nonatomic) IBOutlet UILabel *labelEventName;
@property (strong, nonatomic) IBOutlet UILabel *labelCategory;
@property (strong, nonatomic) IBOutlet UILabel *labelStartDate;
@property (strong, nonatomic) IBOutlet UILabel *labelEndDate;
@property (strong, nonatomic) IBOutlet UILabel *labelStartTime;
@property (strong, nonatomic) IBOutlet UILabel *labelEndTime;
@property (strong, nonatomic) IBOutlet UILabel *labelLocationName;
@property (strong, nonatomic) IBOutlet UILabel *labelAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelCity;
@property (strong, nonatomic) IBOutlet UILabel *labelState;
@property (strong, nonatomic) IBOutlet UILabel *labelZipCode;
@property (strong, nonatomic) IBOutlet UITextView *detailView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


// UI Format

@property (strong, nonatomic) IBOutlet UIButton *buttonBorder;


- (IBAction)submitEvent:(id)sender;


@end
