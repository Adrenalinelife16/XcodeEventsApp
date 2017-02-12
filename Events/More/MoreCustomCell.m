//
//  MoreCustomCell.m
//  Events
//
//  Created by Michael Cather on 2/12/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "MoreCustomCell.h"

@implementation MoreCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
