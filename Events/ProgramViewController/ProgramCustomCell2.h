//
//  ProgramCustomCell2.h
//  Events
//
//  Created by Lamar Artare on 3/13/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "ProgramCustomCell.h"
#import <UIKit/UIKit.h>


@interface ProgramCustomCell2 : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *images;
@property (strong, nonatomic) IBOutlet UILabel *lblDateTime;
@property (strong, nonatomic) IBOutlet UILabel *lblEventName;
@property (strong, nonatomic) IBOutlet UILabel *lblEventDesc;
@property (strong, nonatomic) IBOutlet UIImageView *imgEventImage;
@end
