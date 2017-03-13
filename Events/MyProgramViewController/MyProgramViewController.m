//
//  MyProgramViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "MyProgramViewController.h"
#import "MyProgramCustomCell.h"
#import "ProgramCustomCell.h"
#import "VRGCalendarView.h"
#import "EventCalCell.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"

#import "MMdbsupport.h"

#import "EventList.h"

#import "AboutViewController.h"

@interface MyProgramViewController ()
{
    NSMutableArray *arrMyProgram;//for my tickets
    NSMutableArray *arrayFavouriteProgram;//for my favorites
    NSMutableArray *arrMyCalEvents;//for event calendar eventlist
    NSMutableArray *arrayResponseCalEvents;//for event calendar eventlist response from server
    
    int segmentPosition;//0 or 1 or 2 to check which segment is selected
    UIView *calendarBG;//for calendar view
    
    NSDate *eventDate;//date of event
    
    VRGCalendarView *calView;
    
}
@end

@implementation MyProgramViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [ initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    segmentPosition=0;
    //set current date as event date before getting from server
    NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate =   [NSDate date];
    NSString *strCurrentDate    =   [dateFormatter stringFromDate:currentDate];
    eventDate   =   [dateFormatter dateFromString:strCurrentDate];
        
    [self.tblMainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    [self clickedMyCalender:nil];
    
   }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"My Events";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger totalRows = 0;
    switch (segmentPosition) {
        case 0:
            totalRows = [arrMyCalEvents count];
            break;
        case 1:
            totalRows = [arrayFavouriteProgram count];
            break;
        case 2:
            totalRows = [arrMyProgram count];
            break;
        default:
            return 0;
            break;
    }
    if (totalRows>0) {
        [self.tblMainTable setHidden:NO];
    }
    return totalRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(segmentPosition==2)
    {
        static NSString *CellIdentifier = @"MyProgramCustomCell";
        MyProgramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        if (!cell) {
            cell=[[MyProgramCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSString *strDate   =   [NSString stringWithFormat:@"%@ %@",[[arrMyProgram objectAtIndex:indexPath.row] objectForKey:@"event_start_date"],[[arrMyProgram objectAtIndex:indexPath.row] objectForKey:@"event_start_time"]];
        NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        cell.lblDateTime.text=strDate;
        cell.lblProgramName.text=[[arrMyProgram objectAtIndex:indexPath.row] valueForKey:@"event_name"];
    
        NSString *strPrice = [NSString stringWithFormat:@"%@",[[[arrMyProgram objectAtIndex:indexPath.row] objectForKey:@"ticket"] valueForKey:@"ticket_price"]];
        if ([strPrice floatValue] == 00.00) {
            cell.lblStatus.text = @"Free";
        }
        else{
            cell.lblStatus.text = strPrice;
        }
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:17]};
        CGSize stringsize = [cell.lblDateTime.text sizeWithAttributes:attributes];

        [cell.lblDateTime setFrame:CGRectMake(cell.lblDateTime.frame.origin.x,cell.lblDateTime.frame.origin.y,stringsize.width, 21)];
        [cell.lblStatus setFrame:CGRectMake(stringsize.width+5,cell.lblStatus.frame.origin.y,cell.lblStatus.frame.size.width, cell.lblStatus.frame.size.height)];
        
        return cell;
    }
    else if(segmentPosition==1)
    {
        static NSString *CellIdentifier = @"ProgramCustomCell";
        ProgramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(!cell)
        {
            cell = [[ProgramCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.lblDateTime.text   =   [Utility compareDates:[[arrayFavouriteProgram objectAtIndex:indexPath.row] objectForKey:@"eventenddatetime"] date:[NSDate date]];
        cell.lblEventName.text  =   [[arrayFavouriteProgram objectAtIndex:indexPath.row] objectForKey:@"eventname"];
        cell.lblEventDesc.text  =   [[[arrayFavouriteProgram objectAtIndex:indexPath.row] objectForKey:@"eventcontent"] stringByConvertingHTMLToPlainText];
        cell.lblEventDesc.text  =   [Utility TrimString:cell.lblEventDesc.text];
        
        if ([[[arrayFavouriteProgram objectAtIndex:indexPath.row] objectForKey:@"eventimageurl"] length]>0) {
            [cell.imgEventImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[arrayFavouriteProgram objectAtIndex:indexPath.row] objectForKey:@"eventimageurl"]]] placeholderImage:nil];
        }
        
        cell.imgEventImage.contentMode = UIViewContentModeScaleAspectFill;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(segmentPosition==0)
    {
        static NSString *CellIdentifier = @"EventCalCell";
        EventCalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(!cell){
            cell = [[EventCalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        if ([arrMyCalEvents count]>0) {
            // Configure the cell...
            
            NSDictionary *dictOfCalEvents = [NSDictionary dictionaryWithDictionary:[arrMyCalEvents objectAtIndex:indexPath.row]];

            cell.lblDateTime.text = [Utility getFormatedDateString:[dictOfCalEvents objectForKey:@"event_start_date"] dateFormatString:@"yyyy-MM-dd" dateFormatterString:@"dd MMMM"];
            cell.lblEventName.text=[dictOfCalEvents valueForKey:@"event_name"];

            cell.lblEventPlace.text=[dictOfCalEvents valueForKey:@"location_address"];
        
            
        if ([[arrayFavouriteProgram objectAtIndex:indexPath.row] objectForKey:@"eventimageurl"]) {
                [cell.imgIcon setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[arrayFavouriteProgram objectAtIndex:indexPath.row] objectForKey:@"eventimageurl"]]] placeholderImage:nil];
            }
            
            cell.imgIcon.contentMode = UIViewContentModeScaleAspectFill;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            
            // end image call
            
        }
        return cell;
    }
    else
        return NULL;
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    switch (segmentPosition) {
        case 0:
            return 60;
            break;
        case 1:
            return 162;
            break;
        case 2:
            return 56;
            break;
        default:
            return 0;
            break;
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
       
    EventList *objEvent ;
    BOOL IsMatch = NO;
    if ([segue.identifier isEqualToString:@"program"]) {
        for (int favCount = 0; favCount <[gArrayEvents count]; favCount ++) {
            objEvent = [gArrayEvents objectAtIndex:favCount];
            
            for (NSDictionary *dictDetails in arrayFavouriteProgram) {
                if ([objEvent.eventName isEqualToString:[dictDetails objectForKey:@"eventname"]]) {
                    IsMatch = YES;
                    break;
                }
            }
            if (IsMatch) {
                break;
            }
        }
    }
    else{
        for (int eventCount = 0; eventCount < [gArrayEvents count]; eventCount++) {
            objEvent = [gArrayEvents objectAtIndex:eventCount];
            
            for (NSDictionary *dictEventDetails in arrMyCalEvents) {
                if ([objEvent.eventName isEqualToString:[dictEventDetails objectForKey:@"event_name"]]) {
                    IsMatch = YES;
                    break;
                }
            }
            if (IsMatch) {
                break;
            }
        }
    }
    
    if (IsMatch) {
        AboutViewController *aboutVwController = [segue destinationViewController];
        aboutVwController.eventObj  =   objEvent;
    }
    
}

 
#pragma mark - Button Clicked Function
- (IBAction)clickedMyTickets:(id)sender {
    
    if ([self checkLogin])
    {
        [self.scrollViewMain setContentSize:CGSizeMake(0, 0)];
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
    
        [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"Fetching..."];
        [self getMyTickets];
    }
    else
    {
        [self.scrollViewMain setContentSize:CGSizeMake(0, 0)];
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
        
        [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"Fetching..."];
        [self getMyTickets];

    }
}

- (IBAction)clickedMyFavourites:(id)sender {
    
    [self.scrollViewMain setContentSize:CGSizeMake(0, 0)];
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
    [DSBezelActivityView newActivityViewForView:self.view.window withLabel:@"Fetching favorites..."];
    [self getFavouriteProgramList];
}

- (IBAction)clickedMyCalender:(id)sender {
    segmentPosition=0;
    
    [self.btnMyTickets setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    [self.btnMyCalender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented_left.png"];
    self.btnNotifiction.titleLabel.text=@"";
    [self createCalendarView];
    [self.tblMainTable reloadData];
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
    [self.scrollViewMain addSubview:calendarBG];
}

#pragma mark - VRGCalendarView delegate methods
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    
    calView = calendarView;
    
    CGRect rect=self.tblMainTable.frame;
    rect.origin.y=targetHeight;
    rect.size.height=200;
    self.tblMainTable.frame=rect;
    [self.scrollViewMain setContentSize:CGSizeMake(320, targetHeight+rect.size.height)];
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

/**
 *  Fetch Favorites program list from local
 */
-(void)getFavouriteProgramList
{
    NSMutableArray *arrayFavEvents = [[NSMutableArray alloc] initWithArray:[MMdbsupport MMfetchFavEvents:@"select * from ZFAVOURITEEVENTS"]];
    [DSBezelActivityView removeViewAnimated:YES];
    
    arrayFavouriteProgram = arrayFavEvents;
    
    if (!([arrayFavouriteProgram count]>0)) {
        [Utility alertNotice:APPNAME withMSG:@"No favorite events found!" cancleButtonTitle:@"OK" otherButtonTitle:nil];
    }
    [self.tblMainTable reloadData];
}

/**
 *  Fetch Tickets List From Server.
 */
-(void)getMyTickets
{
    NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getNSUserDefaultValue:KUSERID],@"user_id",@"",@"page",@"",@"page_size", nil];
    
    [Utility GetDataForMethod:NSLocalizedString(@"GETUSERTICKETS_METHOD", @"GETUSERTICKETS_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id response){
        [DSBezelActivityView removeViewAnimated:YES];
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            [Utility alertNotice:@"" withMSG:[response objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
        }
        else if([response isKindOfClass:[NSArray class]]){
            [Utility alertNotice:@"" withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
        }
        [self.tblMainTable reloadData];
        
    }WithFailure:^(NSString *error){
        [DSBezelActivityView removeViewAnimated:YES];
        NSLog(@"%@",error);
    }];
}

@end
