//
//  AboutCustomCell1.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutCustomCell1 : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblEventName;
@property (strong, nonatomic) IBOutlet UILabel *lblEventAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblEventAddressTwo;
- (IBAction)clickedDirection:(id)sender;

@end
