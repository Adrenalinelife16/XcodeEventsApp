//
//  MMdbsupport.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.

#import "MMdbsupport.h"

#import <sqlite3.h>

static sqlite3 *MMdatabase;
static NSString *dbFilePath;
//Set Database Name
#define MMDatabaseName @"EventApp"
@implementation MMdbsupport
+ (BOOL) MMinitializeDb {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    dbFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",MMDatabaseName]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFilePath]) {
		NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:MMDatabaseName ofType:@"sqlite"];
		if (backupDbPath == nil) {
			return NO;
		} else {
			BOOL copiedBackupDb = [[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
			if (!copiedBackupDb) {
				return NO;
			}
		}
	}
    
    return YES;
}
+ (void) MMOpenDataBase
{
    const char *dbFilePathUTF8 = [dbFilePath UTF8String];
	if ([[NSFileManager defaultManager] fileExistsAtPath:dbFilePath]) {
        if (sqlite3_open(dbFilePathUTF8, &MMdatabase) == SQLITE_OK) {
            NSLog(@"Database openend successfully");
        }
        else
        {
            NSLog(@"Failed to open database");
        }
    }
}
+ (void) MMCloseDataBase
{
    if (MMdatabase) {
        if(sqlite3_close(MMdatabase) == SQLITE_OK)
        {
            NSLog(@"Database close successfully");
        }
        else
        {
            NSLog(@"Failed to close database");
        }
    }
}
+ (void) MMExecuteSqlQuery:(NSString *)MMQueryStatement {
    const char *queryStatement = [MMQueryStatement UTF8String];
    char * errMsg;
    if (sqlite3_exec(MMdatabase, queryStatement, NULL, NULL, &errMsg) == SQLITE_OK) {
        NSLog(@"execute successfully");
    }
    else{
        NSLog(@"Execution failed");
    }
}

+ (NSMutableArray *)MMfetchFavEvents:(NSString *)query{
    
    NSMutableArray *arrOfCategories=[[NSMutableArray alloc]init];
    
    const char *dbFilePathUTF8 = [dbFilePath UTF8String];
    
    
    if (sqlite3_open(dbFilePathUTF8, &MMdatabase) == SQLITE_OK) {
        
        const char *sql = [query UTF8String];
        sqlite3_stmt *selectstmt;
        if(sqlite3_prepare_v2(MMdatabase, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
            while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                
                NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                
                const char* eventId = (const char*)sqlite3_column_text(selectstmt, 4);
                NSString *strEventId = eventId == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventId];
                
                const char* eventName = (const char*)sqlite3_column_text(selectstmt, 18);
                NSString *strEventName = eventName == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventName];
                
                const char* eventContent = (const char*)sqlite3_column_text(selectstmt, 7);
                NSString *strEventContent = eventContent == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventContent];
                
                const char* eventImageUrl = (const char*)sqlite3_column_text(selectstmt, 9);
                NSString *strEventImageUrl = eventImageUrl == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventImageUrl];
                
                const char* eventLocLat = (const char*)sqlite3_column_text(selectstmt, 5);
                NSString *strEventLocLat = eventLocLat == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventLocLat];
                
                const char* eventLocLong = (const char*)sqlite3_column_text(selectstmt, 6);
                NSString *strEventLocLong = eventLocLong == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventLocLong];
                
                const char* eventStartDateTime = (const char*)sqlite3_column_text(selectstmt, 20);
                NSString *strEventStartDateTime = eventStartDateTime == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventStartDateTime];
                
                const char* eventEndDateTime = (const char*)sqlite3_column_text(selectstmt, 8);
                NSString *strEndDateTime = eventEndDateTime == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventEndDateTime];
                
                const char* eventLocAdd = (const char*)sqlite3_column_text(selectstmt, 10);
                NSString *strEventLocAdd = eventLocAdd == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventLocAdd];
                
                const char* eventLocCountry = (const char*)sqlite3_column_text(selectstmt, 11);
                NSString *strEventLocCountry = eventLocCountry == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventLocCountry];
                
                const char* eventLocName = (const char*)sqlite3_column_text(selectstmt, 12);
                NSString *strEventLocName = eventLocName == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventLocName];
                
                const char* eventLocState = (const char*)sqlite3_column_text(selectstmt, 16);
                NSString *strEventLocState = eventLocState == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventLocState];
                
                const char* eventLocTown = (const char*)sqlite3_column_text(selectstmt, 17);
                NSString *strEventLocTown = eventLocTown == NULL ? @"" : [[NSString alloc] initWithUTF8String:eventLocTown];
                
                [dic setValue:strEventId forKey:@"eventid"];
                [dic setValue:strEventName forKey:@"eventname"];
                [dic setValue:strEventContent forKey:@"eventcontent"];
                [dic setValue:strEventImageUrl forKey:@"eventimageurl"];
                [dic setValue:strEventLocLat forKey:@"eventloclat"];
                [dic setValue:strEventLocLong forKey:@"eventloclong"];
                [dic setValue:strEventStartDateTime forKey:@"eventstartdatetime"];
                [dic setValue:strEndDateTime forKey:@"eventenddatetime"];
                [dic setValue:strEventLocAdd forKey:@"eventlocadd"];
                [dic setValue:strEventLocCountry forKey:@"eventloccountry"];
                [dic setValue:strEventLocName forKey:@"eventlocname"];
                [dic setValue:strEventLocState forKey:@"eventlocstate"];
                [dic setValue:strEventLocTown forKey:@"eventloctown"];
                
                [arrOfCategories addObject:dic];
                dic=nil;
            }
        }
    }
    return arrOfCategories;
}
@end
