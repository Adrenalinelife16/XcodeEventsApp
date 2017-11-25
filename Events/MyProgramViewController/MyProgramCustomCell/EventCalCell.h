//
//  EventCalCell.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCalCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblDateTime;
@property (strong, nonatomic) IBOutlet UILabel *lblAddressOne;
@property (strong, nonatomic) IBOutlet UILabel *lblAddressTwo;
@property (strong, nonatomic) IBOutlet UILabel *lblEventName;
@property (strong, nonatomic) IBOutlet UIImageView *imgIcon;
@property (strong, nonatomic) IBOutlet UIImageView *discoverLarge;
@property (nonatomic, retain) IBOutlet UIButton *btnRow;

@end
