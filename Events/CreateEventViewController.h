//
//  CreateEventViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventViewController : UIViewController
{
    UIDatePicker *datePicker;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewCE;

@property (strong, nonatomic) IBOutlet UITextField *eventName;
@property (strong, nonatomic) IBOutlet UITextField *startText;
@property (strong, nonatomic) IBOutlet UITextField *endText;

@property (strong, nonatomic) IBOutlet UITextView *detailView;



@property (nonatomic, retain) NSString *titleText;



@end
