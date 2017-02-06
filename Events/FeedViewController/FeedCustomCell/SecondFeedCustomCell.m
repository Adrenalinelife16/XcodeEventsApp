//
//  SecondFeedCustomCell.m
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "SecondFeedCustomCell.h"

@implementation SecondFeedCustomCell

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

- (IBAction)clickedBtnOne:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/search?q=fashon%20week&src=typd"]];
}

- (IBAction)clickedBtnTwo:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/search?q=fashon%20week&src=typd"]];
}
- (IBAction)clickedBtnThree:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/search?q=fashon%20week&src=typd"]];
}
@end
