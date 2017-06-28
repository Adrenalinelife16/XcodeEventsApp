
#define COMMON_COLOR_RED [UIColor colorWithRed:237.0/255.0 green:28.0/255.0 blue:36.0/255.0 alpha:1.0]
#define COMMON_COLOR_GRAY [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:243.0/255.0 alpha:1.0]
#define COMMON_COLOR_DATE [UIColor colorWithRed:135.0/255.0 green:135.0/255.0 blue:135.0/255.0 alpha:1.0]
#define COMMON_COLOR_GRADIANT [UIColor colorWithRed:57.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0]


#define APPNAME @"Adrenaline Life"

#if DEBUGGING
    #warning "App in Debug Mode"
#endif

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define iOSVersion                  [[[UIDevice currentDevice] systemVersion] floatValue]

#define KUSERLATITUDE @"userlatitude"

#define KUSERLONGITUDE @"userlongitude"

#define KUSERID @"user_id"
