//
//  CreateEventViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
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
    self.scrollViewCE.delegate = self;
    
    [self.scrollViewCE setContentSize:CGSizeMake(self.scrollViewCE.frame.size.width, 1068)];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    self.detailView.layer.borderWidth = 1.0f;
    self.detailView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.navigationItem.title = titleText;
    _buttonBorder.layer.borderWidth = 1.0f;
    [_buttonBorder.layer setBorderColor:[[UIColor blackColor] CGColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    [locationName addTarget:address action:@selector(becomeFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    [address addTarget:city action:@selector(becomeFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    [city addTarget:state action:@selector(becomeFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    [state addTarget:zipCode action:@selector(becomeFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    [zipCode addTarget:detailView action:@selector(becomeFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Submit Event to server

- (IBAction)submitEvent:(id)sender
{

    
    NSMutableString *post = [NSMutableString stringWithFormat:@"location_name=%@&location_address=%@&location_city=%@&location_zip=%@&location_state=%@&category=%@&user=%@&event_name=%@&event_info=%@&start_time=%@&end_time=%@&start_date=%@&end_date=%@",
                             
                             locationName.text, address.text, city.text, zipCode.text, state.text, self.navigationItem.title = titleText,
                             [Utility getNSUserDefaultValue:KUSERID], eventName.text, detailView.text, _startTime.text, _endTime.text, _startDate, _endDate];
    
    
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://www.adrenalinelife.org/Adrenaline_Custom/addEvent.php"]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSLog(@"Post Data %@", post);
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
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
    [_startDate resignFirstResponder];
    [_endDate resignFirstResponder];
    [_startTime resignFirstResponder];
    [_endTime resignFirstResponder];
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
    else if (!([self.startDate.text length]>0)) {
        message     =   @"Please enter start date!";
    }else if (!([self.endDate.text length]>0)) {
        message     =   @"Please enter end date!";
    }
    else if (!([self.startTime.text length]>0)) {
        message     =   @"Please enter end date!";
    }
    else if (!([self.endTime.text length]>0)) {
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
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.startDate setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedStartDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.startDate setInputAccessoryView:toolBar];

    

}
- (IBAction)endDate:(UITextField *)sender
{
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.endDate setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedEndDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.endDate setInputAccessoryView:toolBar];
    
 
}

-(void)ShowSelectedStartDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"E, MMM d yyyy"];
    self.startDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    self.startDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.startDate resignFirstResponder];
    
}

-(void)ShowSelectedEndDate
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"E, MMM d yyyy"];
    self.endDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.endDate resignFirstResponder];
}

#pragma mark - Time Picker

- (IBAction)startTime:(UITextField *)sender
{
    
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeTime;
    [self.startTime setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedStartTime)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.startTime setInputAccessoryView:toolBar];
    datePicker.minuteInterval=(60/4);
    
    
}
- (IBAction)endTime:(UITextField *)sender
{
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeTime;
    [self.endTime setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(ShowSelectedEndTime)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.endTime setInputAccessoryView:toolBar];
    datePicker.minuteInterval=(60/4);
    
}

-(void)ShowSelectedStartTime
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"h:mm a"];
    self.startTime.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    self.startTime.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.startTime resignFirstResponder];
    
}

-(void)ShowSelectedEndTime
{   NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"h:mm a"];
    self.endTime.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    [self.endTime resignFirstResponder];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
 
}


@end
