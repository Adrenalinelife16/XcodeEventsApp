//
//  CustomPickerView.h
//  iShapeMyShape
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomPickerDelegate <NSObject>

-(void)customPickerValuePicked:(NSMutableDictionary *)values tag:(int)tag;
-(void)customPickerDidCancel;

@end

@interface CustomPickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>
{
  
    UIPickerView *picker;
    
    NSMutableDictionary *dataSources;
    NSMutableDictionary *selectedValues;
    
    id <CustomPickerDelegate> delegate;
}

@property (nonatomic, retain) id <CustomPickerDelegate> delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id)pickerDelegate tag:(int)tag;
-(void)customPickerAddDataSource:(NSMutableArray *)dataArray component:(int)comp defaultValue:(int)ind;

-(void)showCustomPickerInView:(UIView*)view;
-(void)hideCustomPickerView;

-(void)removeDataSourceForComponent:(int)component;

@end
