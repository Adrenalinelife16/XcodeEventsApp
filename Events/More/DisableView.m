//
//  DisableView.m
//  Adrenaline Life
//
//  Created by Michael Cather on 8/22/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import "DisableView.h"

@interface DisableView()

@property (nonatomic, retain) IBOutlet UIView *myViewFromNib;

@end


@implementation DisableView


-(void)disableBackground {
    
    [[NSBundle mainBundle] loadNibNamed:@"DisableView" owner:self options:nil];


}



@end
