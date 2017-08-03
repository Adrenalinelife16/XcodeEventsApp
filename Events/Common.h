
#define COMMON_COLOR_RED [UIColor colorWithRed:237.0/255.0 green:28.0/255.0 blue:36.0/255.0 alpha:1.0]
#define COMMON_COLOR_GRAY [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:243.0/255.0 alpha:1.0]
#define COMMON_COLOR_DATE [UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1.0]
#define COMMON_COLOR_GRADIANT [UIColor colorWithRed:57.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0]


#define APPNAME @"Adrenaline Life"

#if DEBUGGING
    #warning "App in Debug Mode"
#endif

//#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_ZOOMED (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define iOSVersion                  [[[UIDevice currentDevice] systemVersion] floatValue]

#define KUSERLATITUDE @"userlatitude"

#define KUSERLONGITUDE @"userlongitude"

#define KUSERID @"user_id"

#define KUSER_EMAIL @"user_email"


#define KUSER_ID_TEST @"25"
