//
//  CreateEventViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "CreateEventViewController.h"


@interface CreateEventViewController () <UITextViewDelegate>

@end

@implementation CreateEventViewController
@synthesize eventName, locationName, address, city, state, zipCode, detailView;
@synthesize titleText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollViewCE setContentSize:CGSizeMake(self.scrollViewCE.frame.size.width, 1620)];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    self.detailView.layer.borderWidth = 1.0f;
    self.detailView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.navigationItem.title = titleText;
    _buttonBorder.layer.borderWidth = 1.0f;
    [_buttonBorder.layer setBorderColor:[[UIColor blackColor] CGColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Submit Event to server

- (IBAction)submitEvent:(id)sender
{
    [self IsValid];
    NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:eventName.text,@"eventName",
                                         self.startText.text,@"startText",
                                         self.endText.text,@"endText",
                                         self.locationName.text,@"locationName",
                                         self.address.text,@"address",
                                         self.city.text,@"city",
                                         self.state.text,@"state",
                                         self.zipCode.text,@"zipode",
                                         self.detailView.text,@"detailview", nil];

    
    
    
    
    NSLog(@"Create event button pushed");
    
}


#pragma mark - Upload Photo from iPhone
- (IBAction)uploadImageClicked:(id)sender
{
    NSLog(@"Upload Image Tapped");
}



#pragma mark - Check registration Field validations
-(BOOL)IsValid
{
    NSString *message   =   @"";
    
    if (!([self.eventName.text length]>0)) {
        message     =   @"Please enter event name!";
    }
    else if (!([self.startText.text length]>0)) {
        message     =   @"Please enter start date!";
    }else if (!([self.endText.text length]>0)) {
        message     =   @"Please enter end date!";
    }
    else if (!([self.locationName.text length]>0)) {
        message     =   @"Please enter location name!";
    }
    else if (!([self.address.text length]>0)) {
        message     =   @"Please enter address!";
    }
    else if (!([self.city.text length]>0)) {
        message     =   @"Please enter city!";
    }
    else if (!([self.state.text length]>0)) {
        message     =   @"Please enter state!";
    }
    else if (!([self.zipCode.text length]>0)){
        message     =   @"Please enter zip code!";
    }
    else if (!([self.detailView.text length]>0)){
        message     =   @"Please enter description of event!";
    }

    else
    {
   // Do something here if you want
    }
    
    
    if ([message length]>0) {
        [Utility alertNotice:APPNAME withMSG:message cancleButtonTitle:@"OK" otherButtonTitle:nil];
        return NO;
    }
    return YES;
}



#pragma mark - Date Picker

- (IBAction)startDate:(UITextField *)sender
{
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    [self.startText setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedStartDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.startText setInputAccessoryView:toolBar];

}
- (IBAction)endDate:(UITextField *)sender
{
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDateAndTime;
    [self.endText setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedEndDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.endText setInputAccessoryView:toolBar];
 
}

-(void)ShowSelectedStartDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"E, MMM d yyyy h:mm a"];
    self.startText.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.startText resignFirstResponder];
}

-(void)ShowSelectedEndDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"E, MMM d yyyy h:mm a"];
    self.endText.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.endText resignFirstResponder];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
 
}


@end
