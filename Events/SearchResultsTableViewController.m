//
//  SearchResultsTableViewController.m
//  Events
//
//  Created by Michael Cather on 2/16/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "ProgramCustomCell.h"
#import "SearchCustomCell.h"
#import "Utility.h"
#import "EventList.h"
#import "UIImageView+WebCache.h"

@interface SearchResultsTableViewController ()
{
    
    NSMutableArray *arrayEventList;
}

@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getEventListFromServer
{
    NSDictionary *dictOfEventRequestParameter = [[NSDictionary alloc] initWithObjectsAndKeys:[Utility getNSUserDefaultValue:KUSERID],@"user_id", nil];
    
    [Utility GetDataForMethod:NSLocalizedString(@"GETEVENTS_METHOD", @"GETEVENTS_METHOD") parameters:dictOfEventRequestParameter key:@"" withCompletion:^(id response){
        
        [DSBezelActivityView removeViewAnimated:NO];
        arrayEventList  =   [[NSMutableArray alloc] init];
        
        if ([response isKindOfClass:[NSArray class]]) {
            if ([[[response objectAtIndex:0] allKeys] containsObject:@"status"]) {
                if ([[[response objectAtIndex:0] objectForKey:@"status"] intValue] == 0) {
                    [Utility alertNotice:@"" withMSG:[[response objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
                    gArrayEvents = [[NSMutableArray alloc] initWithArray:arrayEventList];
                    [self.tableView reloadData];
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
                eventObj.eventLocationState     =   [dict objectForKey:@"location_state"];
                eventObj.eventLocationCountry   =   [dict objectForKey:@"location_country"];
                eventObj.eventLocationLatitude  =   [NSNumber numberWithFloat:[[dict objectForKey:@"location_latitude"] floatValue]];
                eventObj.eventLocationLongitude =   [NSNumber numberWithFloat:[[dict objectForKey:@"location_longitude"] floatValue]];
                
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
                
                [arrayEventList addObject:eventObj];
            }
        }
        
        /**
         *  global array for events data.
         */
        gArrayEvents = [[NSMutableArray alloc] initWithArray:arrayEventList];
        
        [self.tableView reloadData];
        
    }WithFailure:^(NSString *error)
     {
         [DSBezelActivityView removeViewAnimated:NO];
         
         
     }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155; //162
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //static NSString *CellIdentifier = @"searchCell";
    //searchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCustomCell" forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"SearchCustomCell";
    SearchCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[SearchCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    EventList *obj = [_searchResults objectAtIndex:indexPath.row];
    
    cell.lblDateTime.text   =   [Utility compareDates:obj.eventStartDateTime date:[NSDate date]];
    cell.lblEventName.text  =   obj.eventName;
    cell.lblEventDesc.text  =   [obj.eventDescription stringByConvertingHTMLToPlainText];
    cell.lblEventDesc.text  =   [Utility TrimString:cell.lblEventDesc.text];
    
    if ([obj.eventImageURL length]) {
        [cell.imgEventImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.eventImageURL]] placeholderImage:nil];
        [cell.imgEventImage setContentMode:UIViewContentModeScaleAspectFill];
        [cell.imgEventImage setClipsToBounds:YES];
    }
    
    cell.imgEventImage.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.searchResults = [(NSArray *)object valueForKey:@"results"];
    [self.tableView reloadData];
     
}


@end
