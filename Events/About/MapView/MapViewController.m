//
//  MapViewController.m
//  Events
//
//  Created by Souvick Ghosh on 2/25/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initializeNavigationBar];
    self.tabBarController.tabBar.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initializeNavigationBar{
    UIImage* image1 = [UIImage imageNamed:@"share.png"];
    CGRect frameimg1 = CGRectMake(0, 0, image1.size.width, image1.size.height);
    UIButton *shareButton = [[UIButton alloc] initWithFrame:frameimg1];
    [shareButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(clickedShare:)
          forControlEvents:UIControlEventTouchUpInside];
    [shareButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *shareButtonBar =[[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    UIImage* image2 = [UIImage imageNamed:@"sendto.png"];
    CGRect frameimg2 = CGRectMake(0, 0, image2.size.width, image2.size.height);
    UIButton *sendtoButton = [[UIButton alloc] initWithFrame:frameimg2];
    [sendtoButton setBackgroundImage:image2 forState:UIControlStateNormal];
    [sendtoButton addTarget:self action:@selector(clickedSendTo:)
           forControlEvents:UIControlEventTouchUpInside];
    [sendtoButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *sendtoButtonBar =[[UIBarButtonItem alloc] initWithCustomView:sendtoButton];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:shareButtonBar,sendtoButtonBar,nil];
}

#pragma mark - Button Clicked
-(IBAction)clickedShare:(id)sender{
    NSArray *activityItems = nil;
    UIImage *appIcon = [UIImage imageNamed:@"Direction.png"];
    NSString *postText = [[NSString alloc] initWithFormat:@"Temp String"];
    activityItems = @[postText,appIcon];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];

}

-(IBAction)clickedSendTo:(id)sender{
    NSArray *activityItems = nil;
    UIImage *appIcon = [UIImage imageNamed:@"Direction.png"];
    NSString *postText = [[NSString alloc] initWithFormat:@"Temp String"];
    activityItems = @[postText,appIcon];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];

}
@end
