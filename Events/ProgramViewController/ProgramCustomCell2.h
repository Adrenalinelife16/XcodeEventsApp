//
//  ProgramCustomCell2.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "ProgramCustomCell.h"
#import <UIKit/UIKit.h>


@interface ProgramCustomCell2 : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *images;
@property (strong, nonatomic) IBOutlet UILabel *lblDateTime;
@property (strong, nonatomic) IBOutlet UILabel *lblEventName;
@property (strong, nonatomic) IBOutlet UILabel *lblEventDesc;
@property (strong, nonatomic) IBOutlet UIImageView *imgEventImage;

@property (strong, nonatomic) IBOutlet UIImageView *imgTransparent;
@end
