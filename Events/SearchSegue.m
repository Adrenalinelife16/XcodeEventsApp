//
//  SearchSegue.m
//  Events
//
//  Created by Michael Cather on 3/30/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "SearchSegue.h"


@implementation SearchSegue


- (void) perform {
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];


    
}


@end
