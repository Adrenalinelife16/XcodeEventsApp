//
//  CreateEventViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventViewController : UIViewController <UITextViewDelegate>
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


// UI Format

@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewCE;
@property (strong, nonatomic) IBOutlet UITextField *startText;
@property (strong, nonatomic) IBOutlet UITextField *endText;
@property (strong, nonatomic) IBOutlet UIButton *buttonBorder;
@property (nonatomic, retain) NSString *titleText;

- (IBAction)submitEvent:(id)sender;



@end
