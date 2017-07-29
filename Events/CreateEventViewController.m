//
//  CreateEventViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "CreateEventViewController.h"
#import "CategoryTableViewController.h"
#import "ReviewCreateEventViewController.h"


@interface CreateEventViewController () <UITextViewDelegate>

@end

@implementation CreateEventViewController
@synthesize eventName, locationName, address, city, state, zipCode, detailView;
@synthesize titleText;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:COMMON_COLOR_RED];
    self.detailView.layer.borderWidth = 1.0f;
    self.detailView.layer.borderColor = [[UIColor blackColor] CGColor];
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


-(void)viewWillAppear:(BOOL)animated {
    
    
    self.navigationItem.title = titleText;
    

    
    
}

-(void)viewDidLayoutSubviews {
   
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Submit Event to server

- (IBAction)sendReview:(id)sender {
    
    [self performSegueWithIdentifier:@"createEventReview" sender:sender];

    /*
    if ([self IsValid]) {
        
        [self performSegueWithIdentifier:@"createEventReview" sender:sender];
    }
     */
    
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
-(BOOL)IsValid {
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *enteredEventName = [eventName text];
    NSString *enteredStartDate = [_startDate text];
    NSString *enteredEndDate = [_endDate text];
    NSString *enteredStartTime = [_startTime text];
    NSString *enteredEndTime = [_endTime text];
    NSString *enteredLocationName = [locationName text];
    NSString *enteredAddress = [address text];
    NSString *enteredCity = [city text];
    NSString *enteredState = [state text];
    NSString *enteredZipCode = [zipCode text];

    NSString *textValue = [NSString stringWithFormat:@"%@", detailView.text];
    
    UIImage *newImage = [UIImage imageWithData:UIImagePNGRepresentation(_imageView.image)];

    
    if ([[segue identifier] isEqualToString:@"createEventReview"]) {
        ReviewCreateEventViewController *destinationView = [segue destinationViewController];
        destinationView.strEventName = enteredEventName;
        destinationView.strCategory = titleText;
        destinationView.strStartDate = enteredStartDate;
        destinationView.strEndDate = enteredEndDate;
        destinationView.strStartTime = enteredStartTime;
        destinationView.strEndTime = enteredEndTime;
        destinationView.strLocationName = enteredLocationName;
        destinationView.strAddress = enteredAddress;
        destinationView.strCity = enteredCity;
        destinationView.strState = enteredState;
        destinationView.strZipCode = enteredZipCode;
        destinationView.userDetailView = textValue;
        destinationView.userImageView = newImage;
        
    }

}


@end
