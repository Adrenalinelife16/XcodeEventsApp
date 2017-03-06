//
//  CreateEventViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "CreateEventViewController.h"


@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollViewCE setContentSize:CGSizeMake(self.scrollViewCE.frame.size.width, 1000)];
     self.navigationItem.title = @"Create Event";
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
 
}


@end
