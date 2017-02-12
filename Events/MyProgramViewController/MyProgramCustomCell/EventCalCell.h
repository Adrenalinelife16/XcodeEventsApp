//
//  EventCalCell.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCalCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblDateTime;
@property (strong, nonatomic) IBOutlet UILabel *lblEventPlace;
@property (strong, nonatomic) IBOutlet UILabel *lblEventName;
@property (strong, nonatomic) IBOutlet UIImageView *imgPlaceIcon;
@property (strong, nonatomic) IBOutlet UIImageView *imgStatusIcon;
@property (nonatomic, retain) IBOutlet UIButton *btnRow;

@end
