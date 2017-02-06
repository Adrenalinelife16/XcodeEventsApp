//
//  ThirdFeedCustomCell.h
//  Events
//
//  Created by Shabbir Hasan Zaheb on 22/02/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdFeedCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *images;
@property (strong, nonatomic) IBOutlet UIImageView *imgMainImage;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
@property (strong, nonatomic) IBOutlet UIButton *btnUserId;
@property (strong, nonatomic) IBOutlet UILabel *lblTweet;
@property (strong, nonatomic) IBOutlet UILabel *lblViewComment;
- (IBAction)clickedUserId:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *clickedViewComments;
@end
