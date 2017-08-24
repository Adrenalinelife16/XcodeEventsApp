//
//  ProgramViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface ProgramViewController : UITableViewController

@property (nonatomic, retain) NSString *filterText;

-(IBAction)createEvent:(id)sender;

-(void)filterProgramArray;

@end
