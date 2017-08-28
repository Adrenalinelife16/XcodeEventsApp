//
//  ProgramViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>




@interface ProgramViewController : UITableViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) NSString *filterText;

-(IBAction)createEvent:(id)sender;

-(void)filterProgramArray;

@end
