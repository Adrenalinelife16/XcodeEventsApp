//
//  NavigateViewController.m
//  Events
//
//  Created by Michael Cather on 3/2/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "NavigateViewController.h"

@interface NavigateViewController ()

@end

@implementation NavigateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgramController"];
    [self.navigationController pushViewController:controller animated:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
