//
//  Utility.h
//
//  Description:  General methods which is used by whole app

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"

@interface Utility : NSObject
{
    
}
extern NSMutableArray *gArrayEvents;

@property(nonatomic, retain)ASIFormDataRequest *request;

+(Utility *)sharedInstance;

+(void)alertNotice:(NSString *)title withMSG:(NSString *)msg cancleButtonTitle:(NSString *)cancleTitle otherButtonTitle:(NSString *)otherTitle;

+(BOOL)IsNetConnected;

+(void)GetDataForMethod:(NSString *)strMethodName parameters:(NSDictionary *)dicOfParameters key:(NSString *)strKey withCompletion:(void (^)(id data))completion WithFailure:(void (^)(NSString *error))failure;

+(void)setNSUserDefaultValueForString:(NSString*)strValue strKey:(NSString*)strKey;

+(NSString*)getNSUserDefaultValue :(NSString*)key;

+(NSString *)TrimString:(NSString *)value;

+(void)afterDelay:(double)delayInSeconds withCompletion:(void(^)(void))completion;

+(NSString *)getFormatedDateString:(NSString*)dateString dateFormatString:(NSString *)strDateFormatterCurrent dateFormatterString:(NSString *)strDateFormatterNew;

+(NSString *)compareDates:(NSString *)strDate date:(NSDate *)anotherDate;

+(CGSize)getTextSize:(NSString *)strText textWidth:(int)textwidth fontSize:(CGFloat)fontsize lineBreakMode:(NSLineBreakMode *)breakMode;

@end