//
//  AboutCustomCell1.h
//  Events
//
//  Created by Souvick Ghosh on 2/25/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutCustomCell1 : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblEventName;
@property (strong, nonatomic) IBOutlet UILabel *lblEventAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblEventDistance;
- (IBAction)clickedDirection:(id)sender;

@end
