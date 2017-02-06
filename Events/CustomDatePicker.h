//
//  CustomDatePicker.h
//  iShapeMyShape
//
//  Created by Rajkumar on 9/01/14.
//  Copyright (c) 2014 DotSquares. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomDatePickerDelegate <NSObject>

-(void)customDatePickerDatePicked:(NSDate *)dateSelected tag:(int)tag;
-(void)customDatePickerDidCancel;

@end

@interface CustomDatePicker : UIView
{
    UIDatePicker *picker;
    NSInteger tag;
    
    id <CustomDatePickerDelegate> delegate;
    UIDatePickerMode pickerMode;
}

-(id)initWithFrame:(CGRect)frame delegate:(id)pickerDelegate tag:(int)tag mode:(UIDatePickerMode)mode;
-(void)showCustomPickerInView:(UIView*)view;
-(void)hideCustomPickerView;

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, retain) id <CustomDatePickerDelegate> delegate;

@end
