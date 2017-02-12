//
//  CustomPickerView.m
//  iShapeMyShape
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "CustomPickerView.h"
#import "CustomDatePicker.h"

#define K_PICKER_HEIGHT 206

#define k_key_initialValue @"initial"
#define k_key_dataArray @"data"

@implementation CustomPickerView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame delegate:(id)pickerDelegate tag:(int)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    self.tag = tag;
    self.delegate = pickerDelegate;
    [self initWithDataSource];
    
    return self;
}

-(void)initWithDataSource
{
    dataSources = [[NSMutableDictionary alloc]init];
    selectedValues = [[NSMutableDictionary alloc]init];
    
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320,K_PICKER_HEIGHT)];
    picker.backgroundColor = [UIColor whiteColor];
    [picker setDataSource: self];
    picker.autoresizingMask = UIViewAutoresizingNone;
    [picker setDelegate: self];
    picker.showsSelectionIndicator = YES;
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

-(void)customPickerAddDataSource:(NSMutableArray *)dataArray component:(int)comp defaultValue:(int)ind
{
    int count = comp;
    
    [dataSources setObject:dataArray forKey:[NSString stringWithFormat:@"%d",count]];
    [picker reloadAllComponents];
   
    if ((ind < dataArray.count) && (ind >= 0)){
        [picker selectRow:ind inComponent:count animated:NO];
        [selectedValues setObject:[dataArray objectAtIndex:ind] forKey:[NSString stringWithFormat:@"%d",count]];
    }
}

-(void)removeDataSourceForComponent:(int)component
{
    [dataSources removeObjectsForKeys:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",component], nil]];
}

-(void)doneBtnTap
{
    [delegate customPickerValuePicked:selectedValues tag:self.tag];
    [self hideCustomPickerView];
}

-(void)cancelBtnTap
{
    [delegate customPickerDidCancel];
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
         self.transform=CGAffineTransformMakeTranslation(0, -picker.frame.size.height-44);
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

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [[dataSources objectForKey:[NSString stringWithFormat:@"%ld",(long)component]] count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return dataSources.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [[dataSources objectForKey:[NSString stringWithFormat:@"%ld",(long)component]] objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {

    return (300.0/dataSources.count);
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [selectedValues setObject:[[dataSources objectForKey:[NSString stringWithFormat:@"%ld",(long)component]] objectAtIndex:row] forKey:[NSString stringWithFormat:@"%ld",(long)component]];
}

@end
