//
//  DiscoverViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DiscoverViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIScrollView *scrlVW;

// UI Buttons

@property (nonatomic, retain) IBOutlet UIButton *butZero;
@property (nonatomic, retain) IBOutlet UIButton *butOne;
@property (nonatomic, retain) IBOutlet UIButton *butTwo;
@property (nonatomic, retain) IBOutlet UIButton *butThree;
@property (nonatomic, retain) IBOutlet UIButton *butFour;
@property (nonatomic, retain) IBOutlet UIButton *butFive;
@property (nonatomic, retain) IBOutlet UIButton *butSix;
@property (nonatomic, retain) IBOutlet UIButton *butSeven;
@property (nonatomic, retain) IBOutlet UIButton *butEight;
@property (nonatomic, retain) IBOutlet UIButton *butNine;



-(IBAction)buttonZero:(id)sender;
-(IBAction)buttonOne:(id)sender;
-(IBAction)buttonTwo:(id)sender;
-(IBAction)buttonThree:(id)sender;
-(IBAction)buttonFour:(id)sender;
-(IBAction)buttonFive:(id)sender;
-(IBAction)buttonSix:(id)sender;
-(IBAction)buttonSeven:(id)sender;
-(IBAction)buttonEight:(id)sender;
-(IBAction)buttonNine:(id)sender;


@end
