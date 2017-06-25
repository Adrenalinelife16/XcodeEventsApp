//
//  TabBarHeight.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.



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
