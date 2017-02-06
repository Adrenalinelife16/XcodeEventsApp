//
//  ProgramDescriptionViewController.h
//  Events
//
//  Created by Jimmy on 24/06/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramDescriptionViewController : UIViewController{
    
    __weak IBOutlet UITextView *txtVWDescription;
}

@property (nonatomic, retain) NSString *strDescription;

@end
