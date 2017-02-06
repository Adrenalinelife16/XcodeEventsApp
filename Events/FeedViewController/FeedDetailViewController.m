//
//  FeedDetailViewController.m
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "FeedDetailViewController.h"

@interface FeedDetailViewController ()

@end

@implementation FeedDetailViewController
@synthesize feedWebView, strFeedURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Feed Details";
    /**
     *  It will load the feed URL in web view.
     */
    [self.feedWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strFeedURL]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web View Delegates
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [DSBezelActivityView newActivityViewForView:self.view.window];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [DSBezelActivityView removeViewAnimated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
}

@end