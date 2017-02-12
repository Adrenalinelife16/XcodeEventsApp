//
//  ProgramDescriptionViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramDescriptionViewController : UIViewController{
    
    __weak IBOutlet UITextView *txtVWDescription;
}

@property (nonatomic, retain) NSString *strDescription;

@end
