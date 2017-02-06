//
//  MyAnnotation.m
//
//

#import "MyAnnotation.h"


@implementation MyAnnotation
@synthesize title,subtitle;
@synthesize coordinate;
@synthesize nTag;


- (id)initWithLocation:(CLLocationCoordinate2D)coord
{
    self = [super init];    
    if (self) {         
        coordinate = coord;     
    }
    return self;    
}
- (NSString *)title {
    
    
	return title;
    
}

@end