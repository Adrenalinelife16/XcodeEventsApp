//
//  LocationManager.m
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
@synthesize locationManager;

- (id)init {
    self = [super init];
    
    if(self) {
        self.locationManager = [CLLocationManager new];
        [self.locationManager setDelegate:self];
        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager startUpdatingLocation];
    }
    
    return self;
}

+ (LocationManager*)sharedInstance {
    static LocationManager *_sharedInstance;
    if(!_sharedInstance) {
        @synchronized(_sharedInstance) {
            _sharedInstance = [LocationManager new];
        }
    }
    
    return _sharedInstance;
}

#pragma mark - CLLocationManager Delegates
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation.horizontalAccuracy < 0)
        return;
    
    NSDate* eventDate = currentLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if(fabs(howRecent)<2.0 && currentLocation.horizontalAccuracy<=100 && currentLocation.horizontalAccuracy>0)
    {
        [Utility setNSUserDefaultValueForString:[NSString stringWithFormat:@"%f",manager.location.coordinate.latitude] strKey:KUSERLATITUDE];
        [Utility setNSUserDefaultValueForString:[NSString stringWithFormat:@"%f",manager.location.coordinate.longitude] strKey:KUSERLONGITUDE];
    }
}

@end
