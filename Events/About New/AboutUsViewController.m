//
//  AbouViewControllers.m
//  Events
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
@synthesize scrlVW;

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
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    // Do any additional setup after loading the view.
    
    if (IS_IPHONE_5) {
        self.scrlVW.frame = CGRectMake(self.scrlVW.frame.origin.x, self.scrlVW.frame.origin.y, self.scrlVW.frame.size.width, self.scrlVW.frame.size.height+88);
    }
    
    txtVWContent.text = NSLocalizedString(@"CONTENT_ABOUTVIEW", @"CONTENT_ABOUTVIEW");
    
    [self.scrlVW setContentSize:CGSizeMake(self.scrlVW.frame.size.width, 400)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
