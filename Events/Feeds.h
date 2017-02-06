//
//  Feeds.h
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feeds : NSObject

@property (nonatomic, strong) NSString *    tweetDateTime;
@property (nonatomic, strong) NSString *    tweetText;
@property (nonatomic, strong) NSString *    tweetURL;
@property (nonatomic, strong) NSString *    tweetUserName;
@property (nonatomic, strong) NSString *    tweetUserScreenName;
@property (nonatomic, strong) NSString *    tweetUserURL;
@property (nonatomic, strong) NSString *    tweetUserDescription;
@property (nonatomic, strong) NSString *    tweetUserLocation;
@property (nonatomic, strong) NSString *    tweetUserProfileImage;

@property (nonatomic, strong) NSString *    facebookMessage;
@property (nonatomic, strong) NSString *    facebookDateTime;
@property (nonatomic, strong) NSString *    facebookPicture;
@property (nonatomic, strong) NSString *    facebookLink;

@property (nonatomic, strong) NSString *    instagramThumbnail;
@property (nonatomic, strong) NSString *    instagramTitle;
@property (nonatomic, strong) NSString *    instagramDescription;
@property (nonatomic, strong) NSString *    instagramDateTime;
@property (nonatomic, strong) NSString *    instagramLink;

// my code test
@property (nonatomic, strong) NSString *    instagramimages;

//thumbnail, title, description, date, link
@end
