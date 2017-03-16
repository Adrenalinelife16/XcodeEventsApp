//
//  TabBarHeight.m
//  Events
//
//  Created by Michael Cather on 3/14/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "TabBarHeight.h"

@implementation TabBarHeight


// Adjust Tab Bar Height


-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = 45;
    
    return  sizeThatFits;
    
}


@end
