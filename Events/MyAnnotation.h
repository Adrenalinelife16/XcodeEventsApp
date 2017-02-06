//
//  MyAnnotation.h
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>{
    
    
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    int nTag;
}


@property (nonatomic,assign)    CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy)  NSString *subtitle;
@property (nonatomic) int nTag;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;
@end
