//
//  MMdbsupport.h
//  Events
//
//  Copyright (c) 2014 Teknowledge Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMdbsupport : NSObject

+ (BOOL) MMinitializeDb;
+ (void) MMOpenDataBase;
+ (void) MMCloseDataBase;
+ (void) MMExecuteSqlQuery:(NSString *)MMQueryStatement;

+ (NSMutableArray *)MMfetchFavEvents:(NSString *)query;

@end