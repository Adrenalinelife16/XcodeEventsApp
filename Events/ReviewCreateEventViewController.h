//
//  ReviewCreateEventViewController.h
//  Adrenaline Life
//
//  Created by Michael Cather on 7/25/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCreateEventViewController : UIViewController

// Fields for event submit
@property (nonatomic,retain) IBOutlet NSString *strEventName;
@property (strong, nonatomic) IBOutlet UILabel *category;
@property (strong, nonatomic) IBOutlet UILabel *locationName;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *state;
@property (strong, nonatomic) IBOutlet UILabel *zipCode;
@property (strong, nonatomic) IBOutlet UITextView *detailView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


// UI Format

@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewCE;
@property (strong, nonatomic) IBOutlet UILabel *startDate;
@property (strong, nonatomic) IBOutlet UILabel *endDate;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UIButton *buttonBorder;


@end
