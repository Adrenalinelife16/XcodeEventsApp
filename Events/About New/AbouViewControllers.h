//
//  AbouViewControllers.h
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbouViewControllers : UIViewController
{
    __weak IBOutlet UITextView * txtVWContent;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrlVW;

@end