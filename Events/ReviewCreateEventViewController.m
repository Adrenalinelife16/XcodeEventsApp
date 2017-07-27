//
//  ReviewCreateEventViewController.m
//  Adrenaline Life
//
//  Created by Michael Cather on 7/25/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import "ReviewCreateEventViewController.h"
#import "CreateEventViewController.h"

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
    // Do any additional setup after loading the view.
    

    
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
    _labelStartDate.text = self.strStartDate;
    _labelEndDate.text = self.strEndDate;
    _labelStartTime.text = self.strStartTime;
    _labelEndTime.text = self.strEndTime;
    _labelLocationName.text = self.strLocationName;
    _labelAddress.text = self.strAddress;
    _labelState.text = self.strState;
    _labelCity.text = self.strCity;
    _labelZipCode.text = self.strZipCode;
    
    _detailView = self.userDetailView;
    _imageView = self.userImageView;
       
    
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
/*
 - (IBAction)submitEvent:(id)sender {
     
     // Set image formatt
     
     
     UIImage *imageFromImageView = _imageView.image;
     NSData *dataImage = [[NSData alloc] init];
     dataImage = UIImagePNGRepresentation(imageFromImageView);
     NSString *stringImage = [dataImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
     
     // set start/end time formatt
     
     
     NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
     [timeFormatter setDateFormat:@"HH:mm:ss"];
     self.startTime.text=[NSString stringWithFormat:@"%@",[timeFormatter stringFromDate:datePicker.date]];
     self.endTime.text=[NSString stringWithFormat:@"%@",[timeFormatter stringFromDate:datePicker.date]];
     
     
     
     
     // set start/end date formatt
     
     
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     self.startDate.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:datePicker.date]];
     self.endDate.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:datePicker.date]];
     
     // Text field info
     
     
     NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:self.eventName.text,@"event_name", self.startDate.text,@"start_date",self.endDate.text,@"end_date",self.startTime.text,@"start_time",self.endTime.text,@"end_time", self.locationName.text,@"location_name",self.address.text,@"location_address",self.city.text,@"location_city",self.state.text,@"location_state",self.zipCode.text,@"location_zip",self.detailView.text,@"event_info",stringImage,@"image",titleText,@"category", nil];
     
     [Utility GetDataForMethod:NSLocalizedString(@"CREATE_EVENT_METHOD", @"CREATE_EVENT_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id response){
         
         
         if ([response isKindOfClass:[NSDictionary class]]) {
             if ([[response objectForKey:@"message"] isEqualToString:@"Sorry, that username already exists!"]) {
                 [Utility alertNotice:APPNAME withMSG:[response objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                 
                 
             }
             
             
             else{
                 
                 
             }
             
         }
         
         else if ([response isKindOfClass:[NSArray class]]) {
             
             if ([[[response objectAtIndex:0] objectForKey:@"message"] isEqualToString:@"Sorry, that email address is already used!"]) {
                 [Utility alertNotice:APPNAME withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                 
                 
             }
             else{
                 
                 
             }
             
             
         }
         [DSBezelActivityView removeViewAnimated:YES];
         
     }
                   WithFailure:^(NSString *error){
                       [DSBezelActivityView removeViewAnimated:YES];
                       NSLog(@"%@",error);
                   }];
    
 }
*/
 @end
