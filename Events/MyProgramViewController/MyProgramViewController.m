//
//  MyProgramViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "MyProgramViewController.h"
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
#import "FavoritesViewController.h"

@interface MyProgramViewController ()
{
    NSMutableArray *arrMyProgram;//for my tickets
    NSMutableArray *arrayFavouriteProgram;//for my favorites
    NSMutableArray *arrMyCalEvents;//for event calendar eventlist
    NSMutableArray *arrayResponseCalEvents;//for event calendar eventlist response from server
    NSMutableArray *arrayFilterResults; // Array that displays on Fav events
    NSMutableArray *arrayCalConversion; // Using for segue to about controller
    NSMutableArray *arrayCalStorage; // Store all events for calendar
    NSMutableArray *arrayFilterMyCalResults; //Store all cal events for segue
    
    int segmentPosition;//0 or 1 or 2 to check which segment is selected
    UIView *calendarBG;//for calendar view
    
    NSDate *eventDate;//date of event
    
    VRGCalendarView *calView;
    
    NSMutableArray *arrayEventList;
    
    
}
@end

@implementation MyProgramViewController
@synthesize eventObjFav;
@synthesize receivedData;
@synthesize arrayFavEvent;


/*
 - (id)initWithStyle:(UITableViewStyle)style
 {
 self = [ initWithStyle:style];
 if (self) {
 // Custom initialization
 }
 return self;
 }
 */

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    segmentPosition=0;
    
    //set current date as event date before getting from server
    NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate =   [NSDate date];
    NSString *strCurrentDate    =   [dateFormatter stringFromDate:currentDate];
    eventDate   =   [dateFormatter dateFromString:strCurrentDate];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented_left.png"];
    
    // issues with displaying cells, possibly
    
//    [self.tblMainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self clickedMyCalender:nil];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Find Your Life";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self createCalendarView];
 //   [self.tblMainTable reloadData];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//   return [arrMyCalEvents count];
    return 1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier = @"EventCalCell";
        EventCalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(!cell){
            cell = [[EventCalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        if ([arrMyCalEvents count]>0) {
            // Configure the cell...
            
            NSDictionary *dictOfCalEvents = [NSDictionary dictionaryWithDictionary:[arrMyCalEvents objectAtIndex:indexPath.row]];
            
            arrayCalConversion = arrMyCalEvents;
           
            EventList *obj = [arrMyCalEvents objectAtIndex:indexPath.row];
            NSString *image = [dictOfCalEvents objectForKey:@"event_image_url"];
            
            cell.lblDateTime.text = [Utility getFormatedDateString:[dictOfCalEvents objectForKey:@"event_start_date"] dateFormatString:@"yyyy-MM-dd" dateFormatterString:@"dd MMMM"];
            cell.lblEventName.text=[dictOfCalEvents valueForKey:@"event_name"];
            
            cell.lblEventPlace.text=[dictOfCalEvents valueForKey:@"location_address"];
            
            
            
            if ([[arrMyCalEvents objectAtIndex:indexPath.row] valueForKey:@"event_image_url"] != nil) {
                

                [cell.imgIcon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image]] placeholderImage:nil];
                
            }
            
            cell.imgIcon.contentMode = UIViewContentModeScaleAspectFill;

        }
    
        return cell;
}

*/


#pragma mark - Button Clicked Function
- (IBAction)clickedMyAttending:(id)sender {
    
    NSString * storyboardName = @"Main_iPhone";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"attendingVC"];
    [self presentViewController:vc animated:NO completion:nil];
    
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
    segmentPosition=1;
    CGRect rect=self.tblMainTable.frame;
    rect.origin.y=0;
    if(IS_IPHONE_5)
        rect.size.height=423;
    else
        rect.size.height=323;
    self.tblMainTable.frame=rect;
    [self.btnMyTickets setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyFavourites setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnMyCalender setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented_middle.png"];
//    [DSBezelActivityView newActivityViewForView:self.view.window withLabel:@"Fetching favorites"];
//    [self getFavorites];

    NSString * storyboardName = @"Main_iPhone";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"favoriteVC"];
    [self presentViewController:vc animated:NO completion:nil];


    
}

- (IBAction)clickedMyCalender:(id)sender {
    segmentPosition=0;
    
    [self.btnMyTickets setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyCalender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented_left.png"];
    self.btnNotifiction.titleLabel.text=@"";
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
 *  Show login view controller with animation
 */
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

/**
 *  remove login view controller with animation
 */
-(void)dismissLoginView
{
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self dismissViewControllerAnimated:NO completion:nil]; }
                    completion:nil];
}

#pragma mark - Calendar Functions
-(void)createCalendarView{
    
    CGRect rect=self.tblMainTable.frame;
    rect.size.height=300;
    calendarBG=[[UIView alloc] initWithFrame:rect];
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=(id)self;
    [calendarBG addSubview:calendar];
    [self.calendarView addSubview:calendarBG];
}

#pragma mark - VRGCalendarView delegate methods
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    
    calView = calendarView;
    
    CGRect rect=self.tblMainTable.frame;
    rect.origin.y=targetHeight;
    rect.size.height=200;
    self.tblMainTable.frame=rect;
    [self.calendarView setContentSize:CGSizeMake(320, targetHeight+rect.size.height)];
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

/**
 *  get events by selected month from server
 *
 *  @param strMonth month for events
 */
-(void)getCalendarData:(NSString *)strMonth
{
    [DSBezelActivityView newActivityViewForView:self.view.window withLabel:@"Loading Events"];
    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSString *strYear = [NSString stringWithFormat:@"%ld",(long)[components year]];
    
    NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:[strMonth intValue]],@"month",strYear,@"year", nil];
    
    [Utility GetDataForMethod:NSLocalizedString(@"GETEVENTSBYMONTH_METHOD", @"GETEVENTSBYMONTH_METHOD") parameters:dictOfParameters key:@"Calendar" withCompletion:^(id response){
        
        [DSBezelActivityView removeViewAnimated:YES];
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
                [self compareEventDateAndSelectedDate];
                NSMutableArray *arrayTempDates = [[NSMutableArray alloc] init];
                for (NSString *str in arrayCalDateSelectedMonth) {
                    [arrayTempDates addObject:[NSNumber numberWithInt:[str intValue]]];
                    arrayCalConversion = arrayTempDates;
                }
                
                [calView markDates:[NSArray arrayWithArray:arrayTempDates]];
           
            }
            else{
                [self.tblMainTable reloadData];
                
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
    NSLog(@"arrayCalWithIds = %@", arrayCalWithIds);
    
    
    /**Loop through each individual event id**/
    for (NSUInteger i = 0, count = [arrayFavouriteProgram count]; i < count; i++){
        
        //Pull single event id from main array
        NSString *arrayId = [[arrayFavouriteProgram[i] valueForKey:@"eventID"] stringValue];
        NSLog(@"arrayId = %@", arrayId);
        NSInteger valueId = [arrayId intValue];
        
        /**Loop through each individual fav id**/
        for (NSUInteger f = 0, count = [arrayCalWithIds count]; f < count; f++){
            //Pull all the event ids out of index/array
            NSString * stringId = [arrayCalWithIds objectAtIndex:f];
            NSLog(@"stringId = %@", stringId);
            NSLog(@"count = %lu", count);
            NSLog(@"f = %lu", f);
            //Pull single event id out of stringId
            //NSString *singleId = stringId[0];
            //Convert singleId string to NSInteger
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
    NSLog(@"final Array = %@", finalArray);
}

/**
 *  Fetch Tickets List From Server.
 */


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
 if ([segue.identifier isEqualToString:@"event_name"]) {
        
        NSIndexPath *selectedRowIndex = [self.tblMainTable indexPathForSelectedRow];
        AboutViewController *aboutVwController = [segue destinationViewController];
        EventList *obj  =   [self->arrayFilterMyCalResults objectAtIndex:selectedRowIndex.row];
        aboutVwController.eventObj  =   obj;
    }
}

@end
