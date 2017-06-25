//
//  EventList.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventList : NSObject

@property (nonatomic, strong) NSNumber *eventID;
@property (nonatomic, strong) NSNumber *eventAllDay;
@property (nonatomic, strong) NSNumber *eventLocationLatitude;
@property (nonatomic, strong) NSNumber *eventLocationLongitude;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventImageURL;
@property (nonatomic, strong) NSString *eventOwner;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *eventStartDateTime;
@property (nonatomic, strong) NSString *eventEndDateTime;
@property (nonatomic, strong) NSString *eventLocationName;
@property (nonatomic, strong) NSString *eventLocationAddress;
@property (nonatomic, strong) NSString *eventLocationState;
@property (nonatomic, strong) NSString *eventLocationTown;
@property (nonatomic, strong) NSString *eventLocationpostcode;
@property (nonatomic, strong) NSString *eventLocationCountry;
//
@property (nonatomic, strong) NSString *eventTicketName;
@property (nonatomic, strong) NSString *eventTicketDescription;
@property (nonatomic, strong) NSString *eventTicketPrice;
@property (nonatomic, strong) NSString *eventTicketStart;
@property (nonatomic, strong) NSString *eventTicketEnd;
@property (nonatomic, strong) NSString *eventTicketMembers;
@property (nonatomic, strong) NSString *eventTicketGuests;
@property (nonatomic, strong) NSString *eventTicketRequired;
@property (nonatomic, strong) NSNumber *eventTicketAvailSpaces;
@property (nonatomic, strong) NSNumber *eventTicketBookedSpaces;
@property (nonatomic, strong) NSNumber *eventTicketTotalSpaces;

@end
