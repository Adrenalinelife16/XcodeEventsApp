//
//  PopUpViewController.m
//  Adrenaline Life
//
//  Created by Michael Cather on 8/11/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import "PopUpViewController.h"


@interface PopUpViewController ()


@end

@implementation PopUpViewController

- (void)viewDidLoad {

     [super viewDidLoad];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dismissPopup:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

@end
