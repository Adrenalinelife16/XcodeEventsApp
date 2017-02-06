//
//  ProgramDescriptionViewController.m
//  Events
//
//  Created by Jimmy on 24/06/14.
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "ProgramDescriptionViewController.h"

@interface ProgramDescriptionViewController ()

@end

@implementation ProgramDescriptionViewController
@synthesize strDescription;

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
    
    self.title = @"Event Description";
    
    self.view.backgroundColor = [UIColor whiteColor];

    txtVWDescription.textColor = [UIColor blackColor];
    txtVWDescription.text = [NSString stringWithFormat:@"%@",self.strDescription];
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
