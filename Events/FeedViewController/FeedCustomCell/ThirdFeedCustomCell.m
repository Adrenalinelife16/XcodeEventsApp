//
//  ThirdFeedCustomCell.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "ThirdFeedCustomCell.h"

@implementation ThirdFeedCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickedUserId:(id)sender {
    //write the delegeate function to go the specified userid
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/search?q=fashon%20week&src=typd"]];
    
}
@end
