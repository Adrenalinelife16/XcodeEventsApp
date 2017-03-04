//
//  HelpViewController.h
//  Events
//
//  Created by Lamar Artare on 3/4/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpViewController : UIViewController
{
    __weak IBOutlet UITextView * txtVWContent;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrlVW;

@end
