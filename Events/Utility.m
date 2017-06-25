//
//  Utility.m
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "Utility.h"
#import "Reachability.h"

@implementation Utility
@synthesize request;

static Utility *_sharedInstance;
//common functions
+(Utility *) sharedInstance
{
    if (_sharedInstance!=nil)
    {
        return _sharedInstance;
    }
    _sharedInstance=[[Utility alloc] init];
    return _sharedInstance;
}

NSMutableArray *gArrayEvents;

#pragma mark show alert msg_labels_t
+(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle{
	UIAlertView *alert;
	if([otherTitle isEqualToString:@""])
		alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:nil,nil];
	else
    {
		alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:otherTitle,nil];
    }
	[alert show];
}

#pragma mark check is net connected or not
+(BOOL)IsNetConnected{
    BOOL isOk = YES;
	//// Where you need it
	Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)){
		/// Create an alert if connection doesn't work
		UIAlertView *myAlert = [[UIAlertView alloc]
								initWithTitle:@"Network connection unavailable"   message:@"You require an internet connection via WiFi or cellular network to use this application."
								delegate:self
								cancelButtonTitle:@"Close"
								otherButtonTitles:nil];
		[myAlert show];
		isOk = NO;
	} 
    return isOk;
}

+(void)GetDataForMethod:(NSString *)strMethodName parameters:(NSDictionary *)dicOfParameters key:(NSString *)strKey withCompletion:(void (^)(id data))completion WithFailure:(void (^)(NSString *error))failure
{
    NSString* apiEndpoint = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"APPLICATION_URL", @"APPLICATION_URL"),strMethodName];
    
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:apiEndpoint]];
    request.requestMethod = @"POST";
    request.timeOutSeconds = 300;
    
    if (![strKey isEqualToString:@"getEvents"]) {
        for (int i=0; i<[[dicOfParameters allKeys] count]; i++) {
            NSString *strKey    =   [[dicOfParameters allKeys] objectAtIndex:i];
            [request setPostValue:[NSString stringWithFormat:@"%@",[dicOfParameters objectForKey:strKey]] forKey:[NSString stringWithFormat:@"%@",strKey]];
        }
    }
    
    __block ASIFormDataRequest *blockRequest    =   request;
    [request startAsynchronous];    
    [request setCompletionBlock:^{
        
        SBJsonParser *parser=[[SBJsonParser alloc]init];
        id responseData=[parser objectWithString:blockRequest.responseString];
        completion(responseData);
        
    }];
    [request setFailedBlock:^{
        //failure;
        NSLog(@"error");
        failure(@"Some error occured while connecting to the network. Please try again.");
        [Utility alertNotice:@"Error!" withMSG:@"Some error occured while connecting to the network. Please try again." cancleButtonTitle:@"OK" otherButtonTitle:nil];
    }];
}

+(void)setNSUserDefaultValueForString:(NSString*)strValue strKey:(NSString*)strKey{
    [[NSUserDefaults standardUserDefaults] setObject:strValue forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(NSString*)getNSUserDefaultValue :(NSString*)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(NSString *)TrimString:(NSString *)value{
    return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(void)afterDelay:(double)delayInSeconds withCompletion:(void(^)(void))completion{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completion();
    });
}

+(NSString *)getFormatedDateString:(NSString*)dateString dateFormatString:(NSString *)strDateFormatterCurrent dateFormatterString:(NSString *)strDateFormatterNew{
    
    NSString *strDate   =   @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:strDateFormatterCurrent];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:strDateFormatterNew];
    
    strDate   =   [dateFormatter stringFromDate:date];
    return strDate;
}

+(NSString *)compareDates:(NSString *)strDate date:(NSDate *)anotherDate{
    
    NSString *strResult = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E, MMM d yyyy h:mm a"];
    NSDate *date1 = [dateFormatter dateFromString:strDate];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    if ([date1 compare:anotherDate] == NSOrderedSame) {

        strResult = [NSString stringWithFormat:@"%@ Today",[dateFormatter stringFromDate:date1]];
    }
    else if ([date1 compare:anotherDate] == NSOrderedAscending){
        
        NSDate *YesterdayDate = [date1 dateByAddingTimeInterval:-1*24*60*60];
        
        if ([date1 compare:YesterdayDate] == NSOrderedSame)
            strResult = [NSString stringWithFormat:@"%@ Yesterday",[dateFormatter stringFromDate:date1]];
        else
            strResult = strDate;
    }
    else if ([date1 compare:anotherDate] == NSOrderedDescending){
        
        NSDateComponents *components= [[NSDateComponents alloc] init];
        [components setDay:1];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *tomorrowDate = [calendar dateByAddingComponents:components toDate:anotherDate options:0];
    
        if ([date1 compare:tomorrowDate] == NSOrderedSame)
            strResult = [NSString stringWithFormat:@"%@ Tomorrow",[dateFormatter stringFromDate:date1]];
        else
            strResult = strDate;
    }
    
    return strResult;
}

+(CGSize)getTextSize:(NSString *)strText textWidth:(int)textwidth fontSize:(CGFloat)fontsize lineBreakMode:(NSLineBreakMode *)breakMode{
    
    CGSize maximumSize = CGSizeMake(textwidth, MAXFLOAT);
    UIFont *myFont = [UIFont systemFontOfSize:fontsize];
    CGSize myStringSize = [strText sizeWithFont:myFont
                              constrainedToSize:maximumSize
                                  lineBreakMode:NSLineBreakByWordWrapping];
    return myStringSize;
}

@end
