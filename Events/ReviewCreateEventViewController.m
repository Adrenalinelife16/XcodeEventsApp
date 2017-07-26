//
//  ReviewCreateEventViewController.m
//  Adrenaline Life
//
//  Created by Michael Cather on 7/25/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import "ReviewCreateEventViewController.h"

@interface ReviewCreateEventViewController ()

@end

@implementation ReviewCreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitEvent:(id)sender {
    

    
    NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:self.eventName.text,@"event_name", self.startDate.text,@"start_date",self.endDate.text,@"end_date",self.startTime.text,@"start_time",self.endTime.text,@"end_time", self.locationName.text,@"location_name",self.address.text,@"location_address",self.city.text,@"location_city",self.state.text,@"location_state",self.zipCode.text,@"location_zip",self.detailView.text,@"event_info",self.imageView.image,@"image",self.category.text,@"category", nil];
    
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

@end
