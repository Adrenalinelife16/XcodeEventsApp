//
//  CreateEventViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventViewController : UIViewController <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    UIDatePicker *datePicker;

}

// Fields for event submit
@property (strong, nonatomic) IBOutlet UITextField *eventName;
@property (strong, nonatomic) IBOutlet UITextField *locationName;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *zipCode;
@property (strong, nonatomic) IBOutlet UITextView *detailView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


// UI Format

@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewCE;
@property (strong, nonatomic) IBOutlet UITextField *startDate;
@property (strong, nonatomic) IBOutlet UITextField *endDate;
@property (strong, nonatomic) IBOutlet UITextField *startTime;
@property (strong, nonatomic) IBOutlet UITextField *endTime;
@property (strong, nonatomic) IBOutlet UIButton *buttonBorder;
@property (nonatomic, retain) NSString *titleText;


@property(nonatomic) NSInteger minuteInterval;


- (IBAction)submitEvent:(id)sender;

- (IBAction)uploadImageClicked:(id)sender;

-(IBAction)backgroundTouched:(id)sender;
-(IBAction)textfieldReturn:(id)sender;





@end
