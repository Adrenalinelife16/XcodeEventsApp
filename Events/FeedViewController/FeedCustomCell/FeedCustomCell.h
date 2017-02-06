//
//  FeedCustomCell.h
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgMainImage;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UILabel *lblTweet;
@property (strong, nonatomic) IBOutlet UILabel *lblDateTime;
@property (strong, nonatomic) IBOutlet UIImageView *imgVWIcon;

- (IBAction)clickedUserId:(id)sender;
- (IBAction)clickedViewComments:(id)sender;

@end