//
//  CreateEventViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventViewController : UIViewController
{
    __weak IBOutlet UITextView * BetaPageText;
}

-(IBAction)btnCreateEvent:(id)sender;
-(IBAction)btnDiscoverCategories:(id)sender;

@end
