//
//  ReviewCreateEventViewController.m
//  Adrenaline Life
//
//  Created by Michael Cather on 7/25/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import "ReviewCreateEventViewController.h"
#import "CreateEventViewController.h"
#import "ProgramViewController.h"
#import "MoreViewController.h"

@interface ReviewCreateEventViewController ()

@end

@implementation ReviewCreateEventViewController
@synthesize strEventName,strCategory,strStartDate,strEndDate,strStartTime,strEndTime;
@synthesize strLocationName,strAddress,strCity,strState,strZipCode;
@synthesize userDetailView,userImageView;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailView.layer.borderWidth = 1.0f;
    self.detailView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    _buttonBorder.layer.borderWidth = 1.0f;
    [_buttonBorder.layer setBorderColor:[[UIColor blackColor] CGColor]];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    self.title = @"Event Review";
    self.navigationController.navigationBar.topItem.title = @"Edit";
    [self.navigationController.navigationBar setTintColor:COMMON_COLOR_RED];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.edgesForExtendedLayout = UIRectEdgeNone;
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    

    _labelEventName.text = self.strEventName;
    _labelCategory.text = self.strCategory;
    _labelStartDate.text = strStartDate;
    _labelEndDate.text = self.strEndDate;
    _labelStartTime.text = self.strStartTime;
    _labelEndTime.text = self.strEndTime;
    _labelLocationName.text = self.strLocationName;
    _labelAddress.text = self.strAddress;
    _labelState.text = self.strState;
    _labelCity.text = self.strCity;
    _labelZipCode.text = self.strZipCode;
    
    _detailView.text = self.userDetailView;
    _imageView.image = self.userImageView;
    
    
}

-(void)viewDidLayoutSubviews {
    
    self.navigationController.navigationBar.translucent = NO;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (IBAction)submitEvent:(id)sender {
     
     // Set image formatt
     
     
     UIImage *imageFromImageView = _imageView.image;
     NSData *dataImage = [[NSData alloc] init];
     dataImage = UIImagePNGRepresentation(imageFromImageView);
     NSString *stringImage = [dataImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
     
     // set start/end time formatt
     
     NSDateFormatter *startTimeFormat = [[NSDateFormatter alloc] init];
     [startTimeFormat setDateFormat:@"h:mm a"];
     NSDate *startTime = [startTimeFormat dateFromString:strStartTime];
     
     [startTimeFormat setDateFormat:@"HH:mm:ss"];
     strStartTime = [startTimeFormat stringFromDate:startTime];
     
     NSDateFormatter *endTimeFormat = [[NSDateFormatter alloc] init];
     [endTimeFormat setDateFormat:@"h:mm a"];
     NSDate *endTime = [endTimeFormat dateFromString:strEndTime];
     
     [endTimeFormat setDateFormat:@"HH:mm:ss"];
     strEndTime = [endTimeFormat stringFromDate:endTime];


     
     
     // set start/end date formatt
     
     NSDateFormatter *startDateFormat = [[NSDateFormatter alloc] init];
     [startDateFormat setDateFormat:@"E, MMM d yyyy"];
     NSDate *startDate = [startDateFormat dateFromString:strStartDate];
     
     [startDateFormat setDateFormat:@"yyyy-MM-dd"];
     strStartDate = [startDateFormat stringFromDate:startDate];
     
     NSDateFormatter *endDateFormat = [[NSDateFormatter alloc] init];
     [endDateFormat setDateFormat:@"E, MMM d yyyy"];
     NSDate *endDate = [endDateFormat dateFromString:strEndDate];
     
     [endDateFormat setDateFormat:@"yyyy-MM-dd"];
     strEndDate = [endDateFormat stringFromDate:endDate];
     

     // Get User ID
     
     NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
     
     // Text field info
     
     NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:self.strEventName,@"event_name", self.strStartDate,@"start_date",self.strEndDate,@"end_date",self.strStartTime,@"start_time",self.strEndTime,@"end_time", self.strLocationName,@"location_name",self.strAddress,@"location_address",self.strCity,@"location_city",self.strState,@"location_state",self.strZipCode,@"location_zip",self.userDetailView,@"event_info",stringImage,@"image",strCategory,@"category", strUserID,@"user", nil];
     
     [Utility GetDataForMethod:NSLocalizedString(@"CREATE_EVENT_METHOD", @"CREATE_EVENT_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id response){
         
         // show alert for create event
         
         UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Event has been successfully completed!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
         [av show];
    //     [self performSelector:@selector(dismiss:) withObject:av afterDelay:2.0];
         
         // delay go back to main events
         
 
     //   [self performSelector:@selector(backToMain) withObject:nil afterDelay:2.0 ];
         
        
         if ([response isKindOfClass:[NSDictionary class]]) {
             if ([[response objectForKey:@"message"] isEqualToString:@"Event has been successfully completed"]) {
                 [Utility alertNotice:APPNAME withMSG:[response objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                 
                 
             } else {
                 
                 
             }
             
         }
         
         else if ([response isKindOfClass:[NSArray class]]) {
             
             if ([[[response objectAtIndex:0] objectForKey:@"message"] isEqualToString:@"Event has been successfully completed"]) {
                 [Utility alertNotice:APPNAME withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
        
             } else {
                 
                 
             }
             
             
         }
         [DSBezelActivityView removeViewAnimated:YES];
         
     }
                   WithFailure:^(NSString *error){
                       [DSBezelActivityView removeViewAnimated:YES];
                       NSLog(@"%@",error);
                   }];
    
 }

-(void)backToMain {
    
    
    MoreViewController *viewController = [[MoreViewController alloc] init];
    [self presentViewController:viewController animated:YES completion:nil];
  //  ProgramViewController *viewController = [[ProgramViewController alloc] init];
  //  [self.navigationController pushViewController:viewController animated:YES];
    
}

-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([string isEqualToString:@"Ok"]) {
        
        
        [self performSegueWithIdentifier:@"ShowMainMenu" sender:self];
        
    }
}


@end
