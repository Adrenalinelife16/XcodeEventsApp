//
//  ProgramViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
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
#import "FeedViewController.h"
#import "FeedCustomCell.h"
#import "SearchResultsTableViewController.h"
#import "FilterViewController.h"




@interface ProgramViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UITabBarControllerDelegate,CLLocationManagerDelegate,UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, strong) SearchResultsTableViewController *resultsTableController;


@property (strong, nonatomic) IBOutlet UIRefreshControl *Refresh;
@property (nonatomic, strong) UISearchController *searchController;
@property (strong, nonatomic) NSArray *results;


@property (strong, nonatomic) IBOutlet UITableView *tblMainTbl;
@property (nonatomic, retain) IBOutlet UIView *myViewFromNib;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerNames;
@property (nonatomic, strong) UITextField *pickerViewTextField;


// Add and remove during search

@property (strong, nonatomic) IBOutlet UIBarButtonItem *myFilterButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *myAddButton;


@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@end

@implementation ProgramViewController

{
    
    NSMutableArray *arrayEventList;
    NSMutableArray *sortedArrayEventList;
    NSArray *filteredEvents;
    NSDate *eventDate;
    UIView *dimView;
    CLLocationManager *locationManager;
 
    
}
@synthesize filterText;
@synthesize sliderDistance, eventObjDistance;
@synthesize searchBarView;

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
    
    
    
    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController ;
    
    [tabBarController setDelegate:self];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self->locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];

    
    // Start Search Bar
    
    _resultsTableController = [[SearchResultsTableViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    _searchController.searchBar.placeholder = @"Search Events";
    
    
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    
    // We want ourselves to be the delegate for this filtered table so didSelectRowAtIndexPath is called for both tables.
    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
    
    self.searchController.hidesNavigationBarDuringPresentation = NO;

    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:COMMON_COLOR_RED];
    

    
    for (UIView *subview in [[_searchController.searchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }

    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    }
    

    // End
    
    // Start Picker View
    
    // set the frame to zero
    self.pickerViewTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.pickerViewTextField];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.pickerViewTextField.inputView = pickerView;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.pickerViewTextField.inputAccessoryView = toolBar;
    
    doneButton.tintColor = [UIColor whiteColor];
    cancelButton.tintColor = [UIColor whiteColor];
    
    self.pickerNames = @[ @"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    
    [pickerView selectRow:0 inComponent:0 animated:YES];
    

    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self.tableView setContentOffset:CGPointZero animated:YES];
}



-(void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:(BOOL)animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    self.navigationItem.titleView = self.searchController.searchBar;
    //   self.tableView.tableHeaderView = self.searchController.searchBar;


    self.definesPresentationContext = YES;
    
    [self checkLogin];
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

     
    [Utility afterDelay:0.01 withCompletion:^{
    }];
    
    
    if ([filterText length] == 0) {
        [self getEventListFromServer];
    } else {
        [self filterProgramArray];
    }
    
}


- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
    self.navigationController.navigationBar.translucent = NO;
}

-(void)willDismissSearchController:(UISearchController *)searchController
{
    self.navigationController.navigationBar.translucent = YES;
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    

    [searchBar resignFirstResponder];
    [self.navigationItem setRightBarButtonItem:nil];
    [self.navigationItem setLeftBarButtonItem:nil];
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


-(void)filterProgramArray {
    

    
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"eventStartDateTime CONTAINS[cd] %@", filterText];
    NSArray *beginWithB = [gArrayEvents filteredArrayUsingPredicate:bPredicate];
    
    
    
    filteredEvents = beginWithB;
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:filteredEvents];
    
    arrayEventList = array;

    
    [self.tblMainTbl reloadData];

    
}


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self.navigationItem setRightBarButtonItem:nil];
    [self.navigationItem setLeftBarButtonItem:nil];

   
}


-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
 
    
    [self.navigationItem setRightBarButtonItem:_myAddButton];
    [self.navigationItem setLeftBarButtonItem:_myFilterButton];
    
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.navigationItem setRightBarButtonItem:_myAddButton];
    [self.navigationItem setLeftBarButtonItem:_myFilterButton];
    
}


-(IBAction)filterDay:(id)sender {
    
    
    [self.pickerViewTextField becomeFirstResponder];


}

- (void)cancelTouched:(UIBarButtonItem *)sender {
    // hide the picker view
    [self.pickerViewTextField resignFirstResponder];
}

- (void)doneTouched:(UIBarButtonItem *)sender {
    // hide the picker view
    [self.pickerViewTextField resignFirstResponder];
    [self filterProgramArray];
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerNames count];
}
#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *item = [_pickerNames objectAtIndex:row];
    
    return item;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        self.filterText = self.pickerNames[row];
    }
    
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return (40.0);
}


#pragma mark - Create Event

-(IBAction)createEvent:(id)sender {
    
    
    NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"])
        
        [self performSegueWithIdentifier:@"CEcategory" sender:self];
    
    else
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:APPNAME message:@"User must login to create an event!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
        [av show];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *string = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([string isEqualToString:@"Login"]) {
        
        [self performSegueWithIdentifier:@"loginView" sender:self];
        
    }
}


#pragma mark - Check login
-(BOOL)checkLogin
{
    NSString *strUserID     =   [NSString stringWithFormat:@"%@",[Utility getNSUserDefaultValue:KUSERID]];
    if ([strUserID length]>0 && ![strUserID isKindOfClass:[NSNull class]] && ![strUserID isEqualToString:@"(null)"])
        
        NSLog(@"Username ID = %@", strUserID);
    
    else
    {
        
        NSLog(@"User is logged out!");
        
    }
    return YES;
}

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
                eventObj.eventStartDateTime     =   [Utility getFormatedDateString:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"event_start_date"],[dict objectForKey:@"event_start_time"]] dateFormatString:@"yyyy-MM-dd HH:mm:ss" dateFormatterString:@"EEEE, MMM d yyyy h:mm a"];
                
                eventObj.eventEndDateTime       =   [Utility getFormatedDateString:[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"event_end_date"],[dict objectForKey:@"event_end_time"]] dateFormatString:@"yyyy-MM-dd HH:mm:ss" dateFormatterString:@"EEEE, MMM d yyyy h:mm a"];
                
                eventObj.eventLocationName      =   [dict objectForKey:@"location_name"];
                eventObj.eventLocationAddress   =   [dict objectForKey:@"location_address"];
                eventObj.eventLocationTown      =   [dict objectForKey:@"location_town"];
                eventObj.eventLocationpostcode  =   [dict objectForKey:@"location_postcode"];
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
    return 250; //162: ProgramCustomCell
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProgramCustomCell2";
    ProgramCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                               
    if(!cell)
    {
        cell = [[ProgramCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    EventList *obj = [arrayEventList objectAtIndex:indexPath.row];  // arrayEventList

    cell.lblDateTime.text   =   [Utility compareDates:obj.eventStartDateTime date:[NSDate date]];
    cell.lblEventName.text  =   obj.eventName;
    cell.lblEventDesc.text  =   [obj.eventDescription stringByConvertingHTMLToPlainText];
    cell.lblEventDesc.text  =   [Utility TrimString:cell.lblEventDesc.text];
    
    
    if ([obj.eventImageURL length]) {
        [cell.imgEventImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.eventImageURL]] placeholderImage:nil];
    } else {
        
        cell.imgEventImage.image = [UIImage imageNamed:@"no_image.png"];
        
    }
    
    cell.imgEventImage.contentMode = UIViewContentModeScaleAspectFill;
    
     
     
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [locationManager stopUpdatingLocation];
    
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([self.searchController isActive]) {
        

        EventList *obj = (tableView == self.tableView) ? self->arrayEventList[indexPath.row]: self.resultsTableController.searchResults[indexPath.row];
        AboutViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutView"];
        detailViewController.eventObj = obj;
        
        
    } else {
        
        EventList *obj = (tableView == self.tableView) ? self->arrayEventList[indexPath.row]: self.resultsTableController.searchResults[indexPath.row];
        AboutViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutView"];
        detailViewController.eventObj = obj;

        }
    
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    EventList *obj = (tableView == self.tableView) ? self->arrayEventList[indexPath.row]: self.resultsTableController.searchResults[indexPath.row];
    AboutViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutView"];
    detailViewController.eventObj = obj;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    [self.navigationItem setRightBarButtonItem:_myAddButton];
    [self.navigationItem setLeftBarButtonItem:_myFilterButton];
    self.searchControllerWasActive = NO;
    
    
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [self->arrayEventList mutableCopy];
    
    // strip out all the leading and trailing spaces
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    
    // build all the "AND" expressions for each value in the searchString
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    for (NSString *searchString in searchItems) {
        
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        NSMutableArray *searchItemsPredicate2 = [NSMutableArray array];
        
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"eventName"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        
        NSExpression *lhs2 = [NSExpression expressionForKeyPath:@"eventDescription"];
        NSExpression *rhs2 = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate2 = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs2
                                       rightExpression:rhs2
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        
        
        // at this OR predicate to our master AND predicate
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:
                                          @[finalPredicate, finalPredicate2]];
        [andMatchPredicates addObject:orMatchPredicates];
        
    }
    
    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate =
    [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
    
    // hand over the filtered results to our search results table
    SearchResultsTableViewController *tableController = (SearchResultsTableViewController *)self.searchController.searchResultsController;
    tableController.searchResults = searchResults;
    [tableController.tableView reloadData];
    
}

NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responser status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}



@end
