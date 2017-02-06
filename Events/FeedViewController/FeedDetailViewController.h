//
//  FeedDetailViewController.h
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedDetailViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *feedWebView;
@property (strong, nonatomic) NSString *strFeedURL;
@end
