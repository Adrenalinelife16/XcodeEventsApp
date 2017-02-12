//
//  MMdbsupport.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.

#import <Foundation/Foundation.h>

@interface MMdbsupport : NSObject

+ (BOOL) MMinitializeDb;
+ (void) MMOpenDataBase;
+ (void) MMCloseDataBase;
+ (void) MMExecuteSqlQuery:(NSString *)MMQueryStatement;

+ (NSMutableArray *)MMfetchFavEvents:(NSString *)query;

@end
