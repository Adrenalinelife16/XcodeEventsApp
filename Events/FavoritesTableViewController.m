//
//  FavoritesTableViewController.m
//  Events
//
//  Created by Michael Cather on 6/28/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "ProgramCustomCell.h"
#import "EventList.h"
#import "AboutViewController.h"
#import "MyFavoriteCustomCell.h"
#import "UIImageView+WebCache.h"

@interface FavoritesTableViewController ()
{
    
    NSMutableArray *arrayFavouriteProgram;//for my favorites
    
    NSMutableArray *arrMyCalEvents;//for event calendar eventlist
    NSMutableArray *arrayResponseCalEvents;//for event calendar eventlist response from server
    NSMutableArray *arrayFilterResults; // Array that displays on Fav events
    NSMutableArray *arrayCalConversion; // Using for segue to about controller
    NSMutableArray *arrayCalStorage; // Store all events for calendar
    NSMutableArray *arrayFilterMyCalResults; //Store all cal events for segue
    
    NSMutableArray *arrayEventList;
    
}

@property (strong, nonatomic) IBOutlet UIRefreshControl *Refresh;

@end

@implementation FavoritesTableViewController
@synthesize arrayFavEvent;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Find Your Life";
    self.navigationController.navigationBar.translucent = NO;
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Find Your Life";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented_middle.png"];
    [self checkLogin];
    
    self.navigationItem.hidesBackButton = YES;
    
    [_btnMyFavourites setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
    

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Refresh:(UIRefreshControl *)sender
{
    // Reload the data.
    if ([self checkLoginBOOL]) {
        // Reload the table data with the new data
        [self.tblFavTable reloadData];
        
        // Restore the view to normal
        [sender endRefreshing];
        
    } else {
        
        NSLog(@"User is not logged in");
    }
    
    
}


#pragma mark - Check login
-(void)checkLogin {
    NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"]) {
        
        NSLog(@"Username ID = %@", strUserID);
        [self getAllEventsFromServer];
    }
    else {
        
        NSLog(@"User is logged out!");
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Please login to favorite an event" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        
    }

}

-(BOOL)checkLoginBOOL
{
    NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"])
        
        NSLog(@"Username ID = %@", strUserID);
    
    else
    {

        UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"Please login to favorite an event" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [av show];
        
        NSLog(@"User is logged out!");
        
    }
    return YES;
}



#pragma mark - Button Clicked Function
- (IBAction)clickedMyAttending:(id)sender {
    
    
    
    
}

- (IBAction)clickedMyFavourites:(id)sender {
    
    /*
     
     [self.btnMyTickets setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
     [self.btnMyFavourites setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [self.btnMyCalender setTitleColor:COMMON_COLOR_RED forState:UIControlStateNormal];
     self.imgSegmentBar.image=[UIImage imageNamed:@"Segmented_middle.png"];
     */
    //[DSBezelActivityView newActivityViewForView:self.view.window withLabel:@"Fetching favorites"];
    //    [self getFavorites];
    
    
}

- (IBAction)clickedMyCalender:(id)sender {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrayFavouriteProgram count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200; //162: ProgramCustomCell
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"ProgramCustomCell";
    ProgramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[ProgramCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    EventList *obj = [arrayFavouriteProgram objectAtIndex:indexPath.row];
    
    if ([obj.eventImageURL length]) {
        
        [cell.imgEventImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.eventImageURL]] placeholderImage:nil];
    } else {
        
        cell.imgEventImage.image = [UIImage imageNamed:@"no_image.png"];
        cell.imgEventImage.layer.cornerRadius = 10;

        
        
    }
    
    cell.imgEventImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.imgEventImage.layer.cornerRadius = 10;

    

    
    cell.lblDateTime.text   =   [Utility compareDates:obj.eventStartDateTime date:[NSDate date]];
    cell.lblEventName.text  =   obj.eventName;
    cell.lblEventDesc.text  =   [obj.eventDescription stringByConvertingHTMLToPlainText];
    cell.lblEventDesc.text  =   [Utility TrimString:cell.lblEventDesc.text];
    
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
    
}


-(void)getFavorites{
    
    
    NSDictionary *dictOfParameters  =   [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getNSUserDefaultValue:KUSERID],@"user_id",@"1",@"page",@"30",@"page_size", nil];
    
    [Utility GetDataForMethod:NSLocalizedString(@"USER_HAS_FAV_EVENT", @"USER_HAS_FAV_EVENT") parameters:dictOfParameters key:@"" withCompletion:^(id response){
        
        arrayFavEvent = response;

    
        if ([[response objectAtIndex:0] containsObject:@"0"]) {
            
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"No Favorite Events" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [av show];
            
        } else {
            
             [self filterFavEventsArray];
            
        }
     
        
    }WithFailure:^(NSString *error){
//        [DSBezelActivityView removeViewAnimated:YES];
        NSLog(@"%@",error);
    }];
    
}

- (void)filterFavEventsArray {
    
    
        //Create emtpy array
        NSMutableArray *finalArray = [NSMutableArray array];
        
        //Pull Array of Ids only from Dictionary
        NSArray *arrayWithIds = [arrayFavEvent valueForKey:@"event_id"];
        
        //Pull all the event ids out of index/array
        NSArray * stringId = [arrayWithIds objectAtIndex:0];
        
        /**Loop through each individual event id**/
        for (NSUInteger i = 0, count = [arrayFavouriteProgram count]; i < count; i++){
            
            //Pull single event id from main array
            NSString *arrayId = [[arrayFavouriteProgram[i] valueForKey:@"eventID"] stringValue];
            NSInteger valueId = [arrayId intValue];
            
            /**Loop through each individual fav id**/
            for (NSUInteger f = 0, count = [stringId count]; f < count; f++){
                
                
                //Pull single event id out of stringId
                NSString *singleId = stringId[f];
                
                //Convert singleId string to NSInteger
                NSInteger value = [singleId intValue];
                
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
        arrayFavouriteProgram = finalArray;
        
        if ([finalArray count]>0) {
            [DSBezelActivityView removeViewAnimated:YES];
            [self.tblFavTable reloadData];
            
        } else {
            
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"No Favorite Events" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [av show];
            
        }
    }     



-(void)getAllEventsFromServer {
    
    
    NSDictionary *dictOfEventRequestParameter = [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getNSUserDefaultValue:KUSERID],@"user_id", nil];
    
    [Utility GetDataForMethod:NSLocalizedString(@"GETEVENTS_METHOD", @"GETEVENTS_METHOD") parameters:dictOfEventRequestParameter key:@"" withCompletion:^(id response){
        
  //      [DSBezelActivityView removeViewAnimated:NO];
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
        [self getFavorites];
        
        
    }WithFailure:^(NSString *error)
     {
         [DSBezelActivityView removeViewAnimated:NO];
         
         
     }];
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"eventDetailsSegue"]) {
        
        NSIndexPath *selectedRowIndex = [self.tblFavTable indexPathForSelectedRow];
        AboutViewController *aboutVwController = [segue destinationViewController];
        EventList *obj  =   [self->arrayFavouriteProgram objectAtIndex:selectedRowIndex.row];
        aboutVwController.eventObj  =   obj;
    }
    
}
@end
