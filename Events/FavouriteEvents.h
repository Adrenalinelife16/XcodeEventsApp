//
//  FavouriteEvents.h
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FavouriteEvents : NSManagedObject

@property (nonatomic, retain) NSNumber * event_all_day;
@property (nonatomic, retain) NSString * event_content;
@property (nonatomic, retain) NSString * event_end_dateTime;
@property (nonatomic, retain) NSNumber * event_id;
@property (nonatomic, retain) NSString * event_image_url;
@property (nonatomic, retain) NSString * event_name;
@property (nonatomic, retain) NSString * event_owner;
@property (nonatomic, retain) NSString * event_start_dateTime;
@property (nonatomic, retain) NSString * event_loc_address;
@property (nonatomic, retain) NSString * event_loc_country;
@property (nonatomic, retain) NSNumber * event_loc_latitude;
@property (nonatomic, retain) NSNumber * event_loc_longitude;
@property (nonatomic, retain) NSString * event_loc_name;
@property (nonatomic, retain) NSString * event_loc_owner;
@property (nonatomic, retain) NSString * event_loc_postcode;
@property (nonatomic, retain) NSString * event_loc_region;
@property (nonatomic, retain) NSString * event_loc_state;
@property (nonatomic, retain) NSString * event_loc_town;

@end
