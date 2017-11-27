//
//  CalendarViewController.m
//  Events
//
//  Created by Michael Cather on 6/28/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "CalendarViewController.h"
#import "MyProgramCustomCell.h"
#import "ProgramCustomCell.h"
#import "VRGCalendarView.h"
#import "EventCalCell.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "FavouriteEvents.h"
#import "AboutViewController.h"
#import "MMdbsupport.h"
#import "EventList.h"
#import "AboutViewController.h"
#import "ProgramViewController.h"
#import "Utility.h"
#import "FavoritesTableViewController.h"
#import "VRGCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+convenience.h"
#import "NSMutableArray+convenience.h"
#import "UIView+convenience.h"

@interface CalendarViewController ()
{
    NSMutableArray *arrMyProgram;//for my tickets
    NSMutableArray *arrayFavouriteProgram;//for my favorites
    NSMutableArray *arrMyCalEvents;//for event calendar eventlist
    NSMutableArray *arrayResponseCalEvents;//for event calendar eventlist response from server
    NSMutableArray *arrayCalConversion; // Using for segue to about controller
    NSMutableArray *arrayFilterMyCalResults; //Store all cal events for segue
    
    int segmentPosition;//0 or 1 or 2 to check which segment is selected
    UIView *calendarBG;//for calendar view
    
    NSDate *eventDate;//date of event
    
    VRGCalendarView *calView;
    
    NSMutableArray *arrayEventList;
    
}


@end

@implementation CalendarViewController
@synthesize eventObjFav;
@synthesize receivedData;
@synthesize arrayFavEvent;



#pragma mark - View Life Cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    //set current date as event date before getting from server
    NSDate *currentDate =   [[NSDate alloc]init];
    NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CDT"]];
    NSString *strCurrentDate    =   [dateFormatter stringFromDate:currentDate];
    eventDate   =   [dateFormatter dateFromString:strCurrentDate];
    
    [self createCalendarView];
    [self clickedMyCalender:nil];
    [self getAllEventsFromServer];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Find Your Life";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.hidesBackButton = YES;

    [_btnMyCalender setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    
   
}

-(void)calendarView:(VRGCalendarView  *)calendarView todaysDate:(NSDate *)today {
    
    
    eventDate   =   [[NSDate alloc] init];
    eventDate   =   today;
    
    [self compareEventDateAndTodaysDate];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Refresh:(UIRefreshControl *)sender
{
    // Reload the data.
     [self clickedMyCalender:nil];
    
    // Reload the table data with the new data
    [self.tblMainTable reloadData];
    
    // Restore the view to normal
    [sender endRefreshing];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110; //162: ProgramCustomCell
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayFilterMyCalResults count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"EventCalCell";
    EventCalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell){
        cell = [[EventCalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([arrayFilterMyCalResults count]>0) {
        // Configure the cell...
        
        EventList *obj = [arrayFilterMyCalResults objectAtIndex:indexPath.row];
        
        
        cell.lblDateTime.text   =   [Utility compareDates:obj.eventStartDateTime date:[NSDate date]];
        cell.lblEventName.text  =   obj.eventName;
        
        cell.lblAddressOne.text = [NSString stringWithFormat:@"%@",obj.eventLocationAddress];
        cell.lblAddressTwo.text = [NSString stringWithFormat:@"%@ %@, %@",obj.eventLocationTown, obj.eventLocationState,obj.eventLocationpostcode];
        
        if ([obj.eventImageURL length]) {
            
            [cell.imgIcon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.eventImageURL]] placeholderImage:nil];
            cell.imgIcon.clipsToBounds = YES;
            cell.imgIcon.layer.cornerRadius = 10;
            cell.discoverLarge.layer.cornerRadius = 10;
        
            
        } else {
            

            cell.imgIcon.image = [UIImage imageNamed:@"no_image.png"];
            cell.imgIcon.clipsToBounds = YES;
            cell.imgIcon.layer.cornerRadius = 10;
            cell.discoverLarge.layer.cornerRadius = 10;
            
        }
        
    }
    
    return cell;
}


#pragma mark - Button Clicked Function
- (IBAction)clickedMyAttending:(id)sender {
    
    // test
    
    /*
     if ([self checkLogin])
     {
     [self.calendarView setContentSize:CGSizeMake(0, 0)];
     [calendarBG removeFromSuperview];
     CGRect rect=self.tblMainTable.frame;
     rect.origin.y=0;
     if (IS_IPHONE_5)
     rect.size.height=423;
     else
     rect.size.height=323;
     self.tblMainTable.frame=rect;
     segmentPosition=2;
     [self.btnMyTickets setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [self.btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
     [self.btnMyCalender setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
     self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented.png"];
     [self.tblMainTable reloadData];
     self.btnNotifiction.titleLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)arrMyProgram.count];
     
     //   [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"Fetching..."];
     [self getMyTickets];
     }
     else
     {
     [self.calendarView setContentSize:CGSizeMake(0, 0)];
     [calendarBG removeFromSuperview];
     CGRect rect=self.tblMainTable.frame;
     rect.origin.y=0;
     if (IS_IPHONE_5)
     rect.size.height=423;
     else
     rect.size.height=323;
     self.tblMainTable.frame=rect;
     segmentPosition=2;
     [self.btnMyTickets setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [self.btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
     [self.btnMyCalender setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
     self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented.png"];
     [self.tblMainTable reloadData];
     self.btnNotifiction.titleLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)arrMyProgram.count];
     
     //    [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"Fetching..."];
     */
    
    
}


- (IBAction)clickedMyFavourites:(id)sender {
    
    [self.calendarView setContentSize:CGSizeMake(0, 0)];
    [calendarBG removeFromSuperview];
 //   [DSBezelActivityView newActivityViewForView:self.view.window withLabel:@"Loading..."];
    
}

- (IBAction)clickedMyCalender:(id)sender {
    
    
}


// add logout method under the else statement

#pragma mark - Check login for MyFavorite and MyTickets
-(BOOL)checkLogin
{
    NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"]) {
        return YES;
    }
    else
        return NO;
}

/**
 
-(void)showLoginScreen
{
    LoginViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    loginView.delegate = self;
    UINavigationController *navController   =   [[UINavigationController alloc] initWithRootViewController:loginView];
    
    [UIView transitionWithView:self.view.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{ [self.view.window.rootViewController presentViewController:navController animated:NO completion:nil]; }
                    completion:nil];
}


-(void)dismissLoginView
{
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self dismissViewControllerAnimated:NO completion:nil]; }
                    completion:nil];
}
*/
#pragma mark - Calendar Functions
-(void)createCalendarView{
    
    CGRect rect=self.calendarView.frame;
    rect.size.height=300; // 300
    calendarBG=[[UIView alloc] initWithFrame:rect];
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=(id)self;
    [calendarBG addSubview:calendar];
    [self.calendarView addSubview:calendarBG];
}

#pragma mark - VRGCalendarView delegate methods
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float) targetHeight animated:(BOOL)animated {
    
    calView = calendarView;
    
    
    CGRect rect=self.tblMainTable.frame;
    rect.origin.y= targetHeight+95; //360
    rect.size.height= 198; // 165
    self.tblMainTable.frame=rect;
    [self.calendarView setContentSize:CGSizeMake(320, targetHeight+rect.size.height)]; // 320
    NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd h:mm:ss"];
    NSDate *currentDate =   [NSDate date];
    NSString *strCurrentDate    =   [dateFormatter stringFromDate:currentDate];
    eventDate   =   [dateFormatter dateFromString:strCurrentDate];
    [self getCalendarData:[NSString stringWithFormat:@"%d",month]];
    
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    
    eventDate   =   [[NSDate alloc] init];
    eventDate   =   date;

    [self compareEventDateAndSelectedDate];
}


-(void)getCalendarData:(NSString *)strMonth
{
 //   [DSBezelActivityView newActivityViewForView:self.view.window withLabel:@"Loading..."];
    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSString *strYear = [NSString stringWithFormat:@"%ld",(long)[components year]];
    
    NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:[strMonth intValue]],@"month",strYear,@"year", nil];
    
    [Utility GetDataForMethod:NSLocalizedString(@"GETEVENTSBYMONTH_METHOD", @"GETEVENTSBYMONTH_METHOD") parameters:dictOfParameters key:@"Calendar" withCompletion:^(id response){
        
  //      [DSBezelActivityView removeViewAnimated:YES];
        if ([response isKindOfClass:[NSArray class]]) {
            arrayResponseCalEvents  =   [[NSMutableArray alloc] init];
            
            if ([[[response objectAtIndex:0] allKeys] containsObject:@"status"]) {
                if ([[[response objectAtIndex:0] objectForKey:@"status"] intValue] == 0) {
                    [self.tblMainTable reloadData];
                    return ;
                }
            }
            
            if ([response count]>0) {
                NSMutableArray *arrayCalDateSelectedMonth = [[NSMutableArray alloc] init];
                for (NSDictionary *dict in response) {
                    [arrayResponseCalEvents addObject:dict];
                    
                    NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *selectedEventDate   =   [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"event_start_date"]]];
                    
                    NSCalendar* calendar = [NSCalendar currentCalendar];
                    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selectedEventDate];
                    NSString *stringMonth  = [NSString stringWithFormat:@"%ld",(long)[components month]];
                    if ([strMonth intValue] == [stringMonth intValue]) {
                        NSString *strDay = [NSString stringWithFormat:@"%ld",(long)[components day]];
                        [arrayCalDateSelectedMonth addObject:strDay];
                    }
                }
     //           [self compareEventDateAndSelectedDate];
                NSMutableArray *arrayTempDates = [[NSMutableArray alloc] init];
                for (NSString *str in arrayCalDateSelectedMonth) {
                    [arrayTempDates addObject:[NSNumber numberWithInt:[str intValue]]];
                    arrayCalConversion = arrayTempDates;
                }
                
                [calView markDates:[NSArray arrayWithArray:arrayTempDates]];
                [self calendarView:nil todaysDate:eventDate];
                
            }
            else{
                
                
                return ;
            }
            
            
        }
        
    }WithFailure:^(NSString *error){
        [DSBezelActivityView removeViewAnimated:YES];
        NSLog(@"%@",error);
    }];
}

/**
 *  Compare selected date with event date, if match than show event for selected date
 */
-(void)compareEventDateAndSelectedDate
{
    arrMyCalEvents  =   [[NSMutableArray alloc] init];
    for (NSDictionary *dictOfEvent in arrayResponseCalEvents) {
        
        NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *selectedEventDate   =   [dateFormatter dateFromString:[NSString stringWithFormat:@"%@",[dictOfEvent objectForKey:@"event_start_date"]]];
        
        if ([eventDate compare:selectedEventDate] == NSOrderedSame) {
            [arrMyCalEvents addObject:dictOfEvent];
        }
    }
    [self filterMyCalEvents];
}


-(void)compareEventDateAndTodaysDate {
    
    NSMutableArray *finalArray = [NSMutableArray array];
    NSMutableArray *finalArray2 = [NSMutableArray array];
    
    //Get Today's Date
    NSDate *currentDate =   [[NSDate alloc]init];
    NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //Todays String
    NSString *strCurrentDate    =   [dateFormatter stringFromDate:currentDate];
    
    
    /**Loop through each individual event id**/
    for (NSUInteger i = 0, count = [arrayResponseCalEvents count]; i < count; i++){
        
        
        //Current array string date
        NSString *stringDate = [arrayResponseCalEvents[i] valueForKey:@"event_start_date"];
        
        
        //if event id = fav id
        if([strCurrentDate isEqualToString:stringDate]) {
            //add that current event into an array
            [finalArray addObject:arrayResponseCalEvents[i]];
            
        }
        //end of main loop
    }
    
    
    //start next loop here to check event_id
    for (NSUInteger i = 0, count = [gArrayEvents count]; i < count; i++){
        
        //Pull single event id from main array
        NSString *arrayId = [[gArrayEvents[i] valueForKey:@"eventID"] stringValue];
        NSInteger valueId = [arrayId intValue];
        
        /**Loop through each individual fav id**/
        for (NSUInteger f = 0, count = [finalArray count]; f < count; f++){
            
            //Pull single event id out of stringId
            NSString *stringDate = [finalArray[f] valueForKey:@"event_id"];
            //Convert singleId string to NSInteger
            NSInteger value = [stringDate intValue];
            
            //if event id = fav id
            if (valueId == value){
                //add that current event into an array
                [finalArray2 addObject:gArrayEvents[i]];
            }
            //end of fav loop
            
        }
    }
    
    //end of method
    arrayFilterMyCalResults = finalArray2;
    [self.tblMainTable reloadData];
    
    
}



-(void)checkUserID{
    
    NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"]) {
        NSLog(@"User ID is %@", strUserID);
    }
    else
        NSLog(@"User is logged out");
}


- (void)filterMyCalEvents {
    
    //Create emtpy array
    NSMutableArray *finalArray = [NSMutableArray array];
    
    //Pull Array of Ids only from Dictionary
    NSArray *arrayCalWithIds = [arrMyCalEvents valueForKey:@"event_id"];
    
    /**Loop through each individual event id**/
    for (NSUInteger i = 0, count = [arrayFavouriteProgram count]; i < count; i++){
        
        //Pull single event id from main array
        NSString *arrayId = [[arrayFavouriteProgram[i] valueForKey:@"eventID"] stringValue];
        NSInteger valueId = [arrayId intValue];
        
        /**Loop through each individual fav id**/
        for (NSUInteger f = 0, count = [arrayCalWithIds count]; f < count; f++){
            //Pull all the event ids out of index/array
            NSString * stringId = [arrayCalWithIds objectAtIndex:f];

            NSInteger value = [stringId intValue];
            
            //if event id = fav id
            if (valueId == value){
                //add that current event into an array
                [finalArray addObject:arrayFavouriteProgram[i]];
            }
            //end of fav loop
        }
        //end of main loop
    }
    //end of method
    arrayFilterMyCalResults = finalArray;
    [self.tblMainTable reloadData];

}

-(void)getAllEventsFromServer {
    
    
    NSDictionary *dictOfEventRequestParameter = [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getNSUserDefaultValue:KUSERID],@"user_id", nil];
    
    [Utility GetDataForMethod:NSLocalizedString(@"GETEVENTS_METHOD", @"GETEVENTS_METHOD") parameters:dictOfEventRequestParameter key:@"" withCompletion:^(id response){
        
        [DSBezelActivityView removeViewAnimated:NO];
        arrayFavouriteProgram  =   [[NSMutableArray alloc] init];
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            if ([[[response objectAtIndex:0] allKeys] containsObject:@"status"]) {
                if ([[[response objectAtIndex:0] objectForKey:@"status"] intValue] == 0) {
                    [Utility alertNotice:@"" withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                    gArrayEvents = [[NSMutableArray alloc] initWithArray:arrayFavouriteProgram];
                    //                 [self.tblMainTable reloadData];
                    return;
                }
            }
            
            NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"event_start_date"  ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
            NSArray *sortedArrayEventList = [response sortedArrayUsingDescriptors:@[descriptor]];
            
            
            for (NSDictionary *dict in sortedArrayEventList) {
                EventList *eventObj = [[EventList alloc] init];
                eventObj.eventID                =   [NSNumber numberWithInt:[[dict objectForKey:@"event_id"] intValue]];
                eventObj.eventName              =   [dict objectForKey:@"event_name"];
                eventObj.eventImageURL          =   [dict objectForKey:@"event_image_url"];
                //       NSLog(@"Data%@",sortedArrayEventList);
                eventObj.eventDescription       =   [dict objectForKey:@"event_content"];
                
                //12.15pm 4 June '14
                eventObj.eventStartDateTime     =   [Utility getFormatedDateString:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"event_start_date"],[dict objectForKey:@"event_start_time"]] dateFormatString:@"yyyy-MM-dd HH:mm:ss" dateFormatterString:@"EEEE, MMM d yyyy h:mm a"];
                
                eventObj.eventEndDateTime       =   [Utility getFormatedDateString:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"event_end_date"],[dict objectForKey:@"event_end_time"]] dateFormatString:@"yyyy-MM-dd HH:mm:ss" dateFormatterString:@"EEEE, MMM d yyyy h:mm a"];
                
                eventObj.eventLocationName      =   [dict objectForKey:@"location_name"];
                eventObj.eventLocationAddress   =   [dict objectForKey:@"location_address"];
                eventObj.eventLocationTown      =   [dict objectForKey:@"location_town"];
                eventObj.eventLocationpostcode  =   [dict objectForKey:@"location_postcode"];
                eventObj.eventLocationState     =   [dict objectForKey:@"location_state"];
                eventObj.eventLocationCountry   =   [dict objectForKey:@"location_country"];
                
                if ([eventObj.eventLocationpostcode length] > 4) {
                    
                    eventObj.eventLocationLatitude  =   [NSNumber numberWithFloat:[[dict objectForKey:@"location_latitude"] floatValue]];
                    eventObj.eventLocationLongitude =   [NSNumber numberWithFloat:[[dict objectForKey:@"location_longitude"] floatValue]];
                    
                    
                }
                
                
                if ([[dict objectForKey:@"ticket"] count]>0) {
                    NSDictionary *dictOfTicket  =   [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"ticket"]];
                    eventObj.eventTicketName            =   [dictOfTicket objectForKey:@"ticket_name"];
                    eventObj.eventTicketDescription     =   [dictOfTicket objectForKey:@"ticket_description"];
                    eventObj.eventTicketPrice           =   [dictOfTicket objectForKey:@"ticket_price"];
                    eventObj.eventTicketStart           =   [dictOfTicket objectForKey:@"ticket_start"];
                    eventObj.eventTicketEnd             =   [dictOfTicket objectForKey:@"ticket_end"];
                    eventObj.eventTicketMembers         =   [dictOfTicket objectForKey:@"ticket_members_roles"];
                    eventObj.eventTicketGuests          =   [dictOfTicket objectForKey:@"ticket_guests"];
                    eventObj.eventTicketRequired        =   [dictOfTicket objectForKey:@"ticket_required"];
                    eventObj.eventTicketAvailSpaces     =   [NSNumber numberWithInt:[[dictOfTicket objectForKey:@"avail_spaces"] intValue]];
                    eventObj.eventTicketBookedSpaces    =   [NSNumber numberWithInt:[[dictOfTicket objectForKey:@"booked_spaces"] intValue]];
                    eventObj.eventTicketTotalSpaces     =   [NSNumber numberWithInt:[[dictOfTicket objectForKey:@"total_spaces"] intValue]];
                }
                
                
                [arrayFavouriteProgram addObject:eventObj];
                
                
            }
        }
        
        /**
         *  global array for events data.
         */
        gArrayEvents = [[NSMutableArray alloc] initWithArray:arrayFavouriteProgram];

        
    }WithFailure:^(NSString *error)
     {
         [DSBezelActivityView removeViewAnimated:NO];
         
         
     }];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"event_cal"]) {
        
        NSIndexPath *selectedRowIndex = [self.tblMainTable indexPathForSelectedRow];
        AboutViewController *aboutVwController = [segue destinationViewController];
        EventList *obj  =   [self->arrayFilterMyCalResults objectAtIndex:selectedRowIndex.row];
        aboutVwController.eventObj  =   obj;
    }
}


@end
