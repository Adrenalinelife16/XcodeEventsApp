//
//  CustomDatePicker.m
//  iShapeMyShape
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "CustomDatePicker.h"
#import "CustomPickerView.h"

#define K_PICKER_HEIGHT 206

@implementation CustomDatePicker

@synthesize delegate, tag;

- (id)initWithFrame:(CGRect)frame delegate:(id)pickerDelegate tag:(int)tag1 mode:(UIDatePickerMode)mode

{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    pickerMode = mode;
    self.tag = tag1;
    self.delegate = pickerDelegate;
    [self addToolbar];
    return self;
}

-(void)addToolbar
{
    picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 320,K_PICKER_HEIGHT)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.autoresizingMask = UIViewAutoresizingNone;
    picker.datePickerMode = pickerMode;
    [self addSubview:picker];

    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.tintColor =[UIColor blackColor];
    [pickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnTap)];
    [barItems addObject:cancelBtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnTap)];
    [barItems addObject:doneBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    [self addSubview:pickerToolbar];
}

-(void)doneBtnTap
{
    [delegate customDatePickerDatePicked:picker.date tag:self.tag];
    [self hideCustomPickerView];    
}

-(void)cancelBtnTap
{
    [delegate customDatePickerDidCancel];
    [self hideCustomPickerView];
}

-(void)showCustomPickerInView:(UIView*)view
{
    for (UIView *subview in view.subviews){
        if ([subview isKindOfClass:[CustomPickerView class]]){
            [(CustomPickerView *)subview hideCustomPickerView];
        }
    }
    for (UIView *subview in view.subviews){
        if ([subview isKindOfClass:[CustomDatePicker class]]){
            [(CustomDatePicker *)subview hideCustomPickerView];
        }
    }
    
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
         self.transform=CGAffineTransformMakeTranslation(0, -self.frame.size.height);
     }
     completion:^(BOOL finished){
         
     }];
}

-(void)hideCustomPickerView
{
    
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
         self.transform=CGAffineTransformMakeTranslation(0, 0);
     }
     completion:^(BOOL finished){
         
     }];
}

@end
