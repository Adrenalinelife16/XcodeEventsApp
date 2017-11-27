//
//  DiscoverTableViewController.m
//  Events
//
//  Created by Michael Cather on 7/7/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "DiscoverTableViewController.h"
#import "EventCalCell.h"
#import "UIImageView+WebCache.h"
#import "DiscoverViewController.h"
#import "AboutViewController.h"



@interface DiscoverTableViewController ()

@end

@implementation DiscoverTableViewController
{
    
    NSArray *arrayDiscoverResults;
    NSMutableArray *discoverAllEvents;
    

}
@synthesize eventObjFav;
@synthesize discoverText;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.navigationBar setTintColor:COMMON_COLOR_RED];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;



    
    [self getAllEventsFromServer];
    
    }

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = discoverText;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130; //162: ProgramCustomCell
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayDiscoverResults count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"DiscoverCalCell";
    EventCalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell){
        cell = [[EventCalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([arrayDiscoverResults count]>0) {
        // Configure the cell...
        
        EventList *obj = [arrayDiscoverResults objectAtIndex:indexPath.row];
        
        
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


-(void)searchDiscoverArray {
    
    NSString *buttonString = discoverText;
    
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"eventDescription CONTAINS[cd] %@ || eventName CONTAINS[cd] %@",buttonString,buttonString];
    NSArray *beginWithB = [discoverAllEvents filteredArrayUsingPredicate:bPredicate];
    
    
    arrayDiscoverResults = beginWithB;
    
    if ([beginWithB count] > 0 ) {
        
        [self.tblDiscover reloadData];
        
    } else {
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"No Events Found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil , nil];
        [av show];
       
            
    }
        
}


-(void)getAllEventsFromServer {
    
    
    NSDictionary *dictOfEventRequestParameter = [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getNSUserDefaultValue:KUSERID],@"user_id", nil];
    
    [Utility GetDataForMethod:NSLocalizedString(@"GETEVENTS_METHOD", @"GETEVENTS_METHOD") parameters:dictOfEventRequestParameter key:@"" withCompletion:^(id response){
        
        [DSBezelActivityView removeViewAnimated:NO];
        discoverAllEvents  =   [[NSMutableArray alloc] init];
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            if ([[[response objectAtIndex:0] allKeys] containsObject:@"status"]) {
                if ([[[response objectAtIndex:0] objectForKey:@"status"] intValue] == 0) {
                    [Utility alertNotice:@"" withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                    gArrayEvents = [[NSMutableArray alloc] initWithArray:discoverAllEvents];
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
                eventObj.eventStartDateTime     =   [Utility getFormatedDateString:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"event_start_date"],[dict objectForKey:@"event_start_time"]] dateFormatString:@"yyyy-MM-dd HH:mm:ss" dateFormatterString:@"E, MMM d yyyy h:mm a"];
                
                eventObj.eventEndDateTime       =   [Utility getFormatedDateString:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"event_end_date"],[dict objectForKey:@"event_end_time"]] dateFormatString:@"yyyy-MM-dd HH:mm:ss" dateFormatterString:@"E, MMM d yyyy h:mm a"];
                
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
                
                
                [discoverAllEvents addObject:eventObj];
                
                
            }
        }
        
        /**
         *  global array for events data.
         */
        gArrayEvents = [[NSMutableArray alloc] initWithArray:discoverAllEvents];
        
        
        [self searchDiscoverArray];
     
        
    }WithFailure:^(NSString *error)
     {
         [DSBezelActivityView removeViewAnimated:NO];
         
         
     }];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"discoverCell"]) {
        
        NSIndexPath *selectedRowIndex = [self.tblDiscover indexPathForSelectedRow];
        AboutViewController *aboutVwController = [segue destinationViewController];
        EventList *obj  =   [self->arrayDiscoverResults objectAtIndex:selectedRowIndex.row];
        aboutVwController.eventObj  =   obj;
    }
}

@end
