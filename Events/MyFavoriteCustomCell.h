//
//  MyFavoriteCustomCell.h
//  Events
//
//  Created by Michael Cather on 6/26/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFavoriteCustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *images;
@property (strong, nonatomic) IBOutlet UILabel *lblDateTime;
@property (strong, nonatomic) IBOutlet UILabel *lblEventName;
@property (strong, nonatomic) IBOutlet UILabel *lblEventDesc;
@property (strong, nonatomic) IBOutlet UIImageView *imgEventImage;

@property (strong, nonatomic) IBOutlet UIImageView *largeBack;

@end
