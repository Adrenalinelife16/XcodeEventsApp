//
//  SecondFeedCustomCell.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondFeedCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *Image2;

@property (strong, nonatomic) IBOutlet UIButton *btnOne;
@property (strong, nonatomic) IBOutlet UIButton *btnTwo;
@property (strong, nonatomic) IBOutlet UIButton *btnThree;

- (IBAction)clickedBtnOne:(id)sender;

- (IBAction)clickedBtnTwo:(id)sender;

- (IBAction)clickedBtnThree:(id)sender;
@end
