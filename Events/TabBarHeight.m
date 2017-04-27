//
//  TabBarHeight.m
//  Events
//
//  Created by Michael Cather on 3/14/17.
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
