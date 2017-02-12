//
//  AbouViewControllers.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.

#import <UIKit/UIKit.h>

@interface AbouViewControllers : UIViewController
{
    __weak IBOutlet UITextView * txtVWContent;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrlVW;

@end
