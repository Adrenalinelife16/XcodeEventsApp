//
//  ProgramViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "ProgramViewController.h"
#import "ProgramCustomCell.h"
#import "EventList.h"
#import "MyEventTickets.h"
#import "AboutViewController.h"
#import "UIImageView+WebCache.h"
#import "CreateEventViewController.h"
#import "Utility.h"
#import "SearchResultsTableViewController.h"


@interface ProgramViewController () <UISearchResultsUpdating>
{
    
    NSMutableArray *arrayEventList;
    NSMutableArray *sortedArrayEventList;
    NSDate *eventDate;
    NSArray *results;
    NSArray *searchResults;
    
}

- (IBAction)Search:(UIBarButtonItem *)sender;


@property (strong, nonatomic) IBOutlet UIRefreshControl *Refresh;
@property (strong, nonatomic) UISearchController *controller;
@property (strong, nonatomic) NSArray *results;
@end

@implementation ProgramViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate =   [NSDate date];
    NSString *strCurrentDate    =   [dateFormatter stringFromDate:currentDate];
    eventDate   =   [dateFormatter dateFromString:strCurrentDate];
    
    SearchResultsTableViewController *searchResults = (SearchResultsTableViewController *) self.controller.searchResultsController;
    [self addObserver:searchResults forKeyPath:@"results" options:NSKeyValueObservingOptionNew context:nil];
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"Events";

//      Uncomment after BETA release
    
//    [self checkLogin];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    [Utility afterDelay:0.01 withCompletion:^{
        [DSBezelActivityView newActivityViewForView:self.view.window];
        [self getEventListFromServer];
    }];
    
}

- (IBAction)Refresh:(UIRefreshControl *)sender
{
    // Reload the data.
    [self getEventListFromServer];
    
    // Reload the table data with the new data
    [self.tableView reloadData];
    
    // Restore the view to normal
    [sender endRefreshing];
}

#pragma mark - Check login
-(void)checkLogin
{
    NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"])
        
        NSLog(@"User ID is %@", strUserID);
    
    else
    {
        NSLog(@"User is logged out!");
    }

    
}

/*
- (IBAction)Search:(UIBarButtonItem *)sender {
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    
}
*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Get All Event's from server
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   return [arrayEventList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155; //162
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProgramCustomCell";
    ProgramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                               
    if(!cell)
    {
        cell = [[ProgramCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    EventList *obj = [arrayEventList objectAtIndex:indexPath.row];

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
    
    
//    
//    UIImage *img = [UIImage imageNamed:@"no_image.jpg"];
//    [UIImageView ];
//    UIImageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y,
//                                 img.size.width, img.size.height);
    
    return cell;
}

#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"AboutView"]) {
        
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        AboutViewController *aboutVwController = [segue destinationViewController];
        EventList *obj  =   [arrayEventList objectAtIndex:selectedRowIndex.row];
        aboutVwController.eventObj  =   obj;
    }
    
}

#pragma mark - Search Events

- (UISearchController *)controller {
    
    if (!_controller) {
        //
       // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ProgramController" bundle:nil];
        SearchResultsTableViewController *resultsController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResults"];
        
        
        //
        _controller = [[UISearchController alloc] initWithSearchResultsController:resultsController];
        _controller.searchResultsUpdater = self;
        
        
    }
    return _controller;
}

#pragma mark - Search Results Updater

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    self.results = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventName contains [cd] %@", self.controller.searchBar.text];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [cd] %@", self.controller.searchBar.text];
    self.results = [self->arrayEventList filteredArrayUsingPredicate:predicate];
    
}


- (IBAction)searchButtonPressed:(id)sender {
    [self presentViewController:self.controller animated:YES completion:nil];
}

@end
