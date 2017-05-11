//
//  CreateEventViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "CreateEventViewController.h"
#import "CategoryTableViewController.h"


@interface CreateEventViewController () <UITextViewDelegate>

@end

@implementation CreateEventViewController
@synthesize eventName, locationName, address, city, state, zipCode, detailView;
@synthesize titleText;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollViewCE setContentSize:CGSizeMake(self.scrollViewCE.frame.size.width, 1000)];
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
    
    NSString *category = titleText;
    
    
    NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:eventName.text,@"eventName",
                                         self.startText.text,@"startText",
                                         self.endText.text,@"endText",
                                         self.locationName.text,@"locationname",
                                         self.address.text,@"address",
                                         self.city.text,@"city",
                                         self.state.text,@"state",
                                         self.zipCode.text,@"zipode",
                                         self.detailView.text,@"eventInfo",
                                         self.navigationItem.title = titleText,@"category", nil];
    
    
    [Utility GetDataForMethod:NSLocalizedString(@"CREATE_EVENT_METHOD", @"CREATE_EVENT_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id response){
        
        [DSBezelActivityView removeViewAnimated:YES];
        
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            [Utility alertNotice:@"" withMSG:[response objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
        }
        else if([response isKindOfClass:[NSArray class]]){
            [Utility alertNotice:@"" withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
        }
        
    }WithFailure:^(NSString *error){
        [DSBezelActivityView removeViewAnimated:YES];
        NSLog(@"%@",error);
    }];
    
    NSLog(@"Create event button pushed");
}




#pragma mark - Upload Photo from iPhone
- (IBAction)uploadImageClicked:(id)sender
{
   
    [self openImageGallery];
    
}

- (void)openImageGallery
{
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Upload image to display on your event"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                 picker.delegate = self;
                                 picker.allowsEditing = YES;
                                 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                 
                                 [self presentViewController:picker animated:YES completion:NULL];
                                 NSLog(@"Camera button pushed");
                                 
                             }];
    
    UIAlertAction *gallery = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                 picker.delegate = self;
                                 picker.allowsEditing = YES;
                                 picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                 
                                 [self presentViewController:picker animated:YES completion:NULL];
                                 
                                 NSLog(@"Button Pushed to open Gallery");
                                 
                                 
                             }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action)
                             {
                                 
                                 NSLog(@"Button Pushed to cancel");
                                 
                             }];
    
    
    [alert addAction:camera];
    [alert addAction:gallery];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


// Hide keyboard when touch background

-(IBAction)backgroundTouched:(id)sender
{
    [eventName resignFirstResponder];
    [locationName resignFirstResponder];
    [address resignFirstResponder];
    [city resignFirstResponder];
    [state resignFirstResponder];
    [zipCode resignFirstResponder];
    [detailView resignFirstResponder];
    [_startText resignFirstResponder];
    [_endText resignFirstResponder];
}

//Hide keyboard when touch return

-(IBAction)textfieldReturn:(id)sender
{
    [sender resignFirstResponder];
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
    datePicker.minuteInterval=(60/4);

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
    datePicker.minuteInterval=(60/4);
 
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
