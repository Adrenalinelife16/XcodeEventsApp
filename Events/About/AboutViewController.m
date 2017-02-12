//
//  AboutViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutCustomCell1.h"
#import "AboutCustomCell2.h"
#import "AboutCustomCell3.h"
#import "LocationManager.h"
#import "MyAnnotation.h"
#import "MyProgramViewController.h"
#import "FavouriteEvents.h"
#import "AppDelegate.h"

#import "ProgramDescriptionViewController.h"

@interface AboutViewController ()
{
    float descriptionTextHeight;
}

@end

@implementation AboutViewController
@synthesize scrollViewMain, eventLocationMapView;
@synthesize eventObj;
@synthesize tblView;
@synthesize eventRegisterView;
@synthesize txtViewComment, txtFieldBookingSpaces, lblComment, lblTotalCost;
@synthesize arrayTotalSpaces;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initializeNavigationBar];
    
    descriptionTextHeight = [Utility getTextSize:self.eventObj.eventDescription textWidth:300 fontSize:14.0f lineBreakMode:NSLineBreakByWordWrapping].height;
    
    self.tblView.frame = CGRectMake(self.tblView.frame.origin.x, self.tblView.frame.origin.y, self.tblView.frame.size.width, self.tblView.frame.size.height+descriptionTextHeight);
    vwFreeRegisterBtn.frame = CGRectMake(vwFreeRegisterBtn.frame.origin.x, self.tblView.frame.origin.y+self.tblView.frame.size.height, vwFreeRegisterBtn.frame.size.width, vwFreeRegisterBtn.frame.size.height);
    
    if (IS_IPHONE_5) {
        self.scrollViewMain.frame = CGRectMake(self.scrollViewMain.frame.origin.x, self.scrollViewMain.frame.origin.y, self.scrollViewMain.frame.size.width, self.scrollViewMain.frame.size.height+100);
    
        self.scrollViewMain.contentSize = CGSizeMake(self.scrollViewMain.frame.size.width, vwFreeRegisterBtn.frame.origin.y+vwFreeRegisterBtn.frame.size.height+50);
    }
    else{
        self.scrollViewMain.contentSize = CGSizeMake(self.scrollViewMain.frame.size.width, vwFreeRegisterBtn.frame.origin.y+vwFreeRegisterBtn.frame.size.height+50);
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=NO;
    /**
     *  get location using locationmanager singleton class
     */
    [LocationManager sharedInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Initialize Navigation bar
-(void)initializeNavigationBar{
    self.title = self.eventObj.eventName;
    UIImage* image1 = [UIImage imageNamed:@"share.png"];
    CGRect frameimg1 = CGRectMake(0, 0, image1.size.width, image1.size.height);
    UIButton *shareButton = [[UIButton alloc] initWithFrame:frameimg1];
    [shareButton setImage:image1 forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"share2.png"] forState:UIControlStateSelected];
    [shareButton addTarget:self action:@selector(clickedShare:)
          forControlEvents:UIControlEventTouchUpInside];
    [shareButton setShowsTouchWhenHighlighted:YES];
    /**
     *  get events detail data from local on basis of eventID
     */
    NSMutableArray *arrayTemp = [[NSMutableArray alloc] initWithArray:[MMdbsupport MMfetchFavEvents:[NSString stringWithFormat:@"select * from ZFAVOURITEEVENTS where ZEVENT_ID = '%@'",self.eventObj.eventID]]];
    if ([arrayTemp count]>0) {
        shareButton.selected=YES;
    }
    UIBarButtonItem *shareButtonBar =[[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:shareButtonBar,nil];
    [self addLocationPinOnMap];
}

#pragma mark - Button Clicked
-(IBAction)clickedShare:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.selected) {
        /**
         *  delete event from local to remove from favourites list
         */
        btn.selected=NO;
        [MMdbsupport MMExecuteSqlQuery:[NSString stringWithFormat:@"delete from ZFAVOURITEEVENTS where ZEVENT_ID = '%@'",self.eventObj.eventID]];
        [Utility alertNotice:APPNAME withMSG:@"Event removed from favorite!" cancleButtonTitle:@"OK" otherButtonTitle:nil];
    }
    else{
        
        /**
         *  add event to local to add in favorites list
         */
        
        btn.selected = YES;
        AppDelegate *appdel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        FavouriteEvents *objData = [NSEntityDescription insertNewObjectForEntityForName:@"FavouriteEvents" inManagedObjectContext:appdel.managedObjectContext];
        objData.event_all_day       =   self.eventObj.eventAllDay;
        objData.event_content       =   self.eventObj.eventDescription;
        objData.event_end_dateTime  =   self.eventObj.eventEndDateTime;
        objData.event_id            =   self.eventObj.eventID;
        objData.event_image_url     =   self.eventObj.eventImageURL;
        objData.event_name          =   self.eventObj.eventName;
        objData.event_owner         =   @"";
        objData.event_start_dateTime=   self.eventObj.eventStartDateTime;
        objData.event_loc_address   =   self.eventObj.eventLocationAddress;
        objData.event_loc_country   =   self.eventObj.eventLocationCountry;
        objData.event_loc_latitude  =   self.eventObj.eventLocationLatitude;
        objData.event_loc_longitude =   self.eventObj.eventLocationLongitude;
        objData.event_loc_name      =   self.eventObj.eventLocationName;
        objData.event_loc_owner     =   @"";
        objData.event_loc_postcode  =   @"";
        objData.event_loc_region    =   @"";
        objData.event_loc_state     =   [NSString stringWithFormat:@"%@",self.eventObj.eventLocationState];
        objData.event_loc_town      =   [NSString stringWithFormat:@"%@",self.eventObj.eventLocationTown];
        
        [appdel.managedObjectContext save:nil];
        
        [Utility alertNotice:APPNAME withMSG:@"Event added as favorite!" cancleButtonTitle:@"OK" otherButtonTitle:nil];
    }
}

-(IBAction)btnEventRegistrationPressed:(id)sender
{
    if ([self checkLogin]) {

        self.arrayTotalSpaces = [[NSMutableArray alloc] init];
        for (int spaceCount=0; spaceCount<[self.eventObj.eventTicketTotalSpaces intValue]; spaceCount++) {
            
            [self.arrayTotalSpaces addObject:[NSString stringWithFormat:@"%d",spaceCount+1]];
        }
        
        self.txtViewComment.layer.borderColor = [UIColor blackColor].CGColor;
        self.txtViewComment.layer.borderWidth = 1.0f;
        self.txtViewComment.layer.cornerRadius = 6.0f;
        
        [self.eventRegisterView setHidden:NO];
        
        if (IS_IPHONE_5) {
            [self.eventRegisterView setFrame:CGRectMake(self.eventRegisterView.frame.origin.x, self.eventRegisterView.frame.origin.y, self.eventRegisterView.frame.size.width, self.eventRegisterView.frame.size.height+88)];
            for (UIView *vw in self.eventRegisterView.subviews) {
                if ([vw isKindOfClass:[UIButton class]]) {
                }
            }
        }
        else
        {
            [self.lblComment setFrame:CGRectMake(self.lblComment.frame.origin.x, self.lblComment.frame.origin.y-35, self.lblComment.frame.size.width, self.lblComment.frame.size.height)];
            [self.txtViewComment setFrame:CGRectMake(self.txtViewComment.frame.origin.x, self.txtViewComment.frame.origin.y-35, self.txtViewComment.frame.size.width, self.txtViewComment.frame.size.height)];
        }
        
        if (![self.eventObj.eventTicketPrice isKindOfClass:[NSNull class]] && ![self.eventObj.eventTicketPrice isEqualToString:@"(null)"] && [self.eventObj.eventTicketPrice length]>0) {
            
            if (![self.eventObj.eventTicketPrice isEqualToString:@"free"] || ![self.eventObj.eventTicketPrice isEqualToString:@"Free"]) {
            
                self.lblTotalCost.hidden = NO;
            
                [self.lblTotalCost setText:[NSString stringWithFormat:@"Total cost : %@",self.eventObj.eventTicketPrice]];
            }
        }
    }
    else{
        [self showLoginScreen];
    }
}

#pragma mark - Event Registration View Clicked events
-(IBAction)btnCancelPressed:(id)sender
{
    [self.eventRegisterView setHidden:YES];
}

/**
 *  By Tap on submit button user can book ticket for event
 */
-(IBAction)btnSubmitPressed:(id)sender
{
    if ([self isValid]) {
        [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"Processing..."];
        
        NSDictionary *dictOfParameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[Utility getNSUserDefaultValue:KUSERID] intValue]],@"user_id",self.eventObj.eventID,@"event_id",self.txtFieldBookingSpaces.text,@"booking_spaces",self.txtViewComment.text,@"booking_comment", nil];

        [Utility GetDataForMethod:NSLocalizedString(@"BOOKTICKET_METHOD", @"BOOKTICKET_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id data){
        
            [DSBezelActivityView removeViewAnimated:YES];
            if ([data isKindOfClass:[NSDictionary class]]) {
                if (self.lblTotalCost.hidden) {
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:[data objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    av.tag = 1001;
                    [av show];
                }
                else
                {
                    NSString *strURL = [[data objectForKey:@"payment_page_link"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    TSMiniWebBrowser *webBrowser = [[TSMiniWebBrowser alloc] initWithUrl:[NSURL URLWithString:strURL]];
                    webBrowser.delegate = self;
                    [webBrowser setFixedTitleBarText:@"Book ticket"];
                    webBrowser.strHtmlContent=@"";
                    webBrowser.mode = TSMiniWebBrowserModeModal;
                    webBrowser.barStyle = UIBarStyleDefault;
                    if (webBrowser.mode == TSMiniWebBrowserModeModal) {
                        webBrowser.modalDismissButtonTitle = @"Back";
                        [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow];
                        
                        [self.navigationController presentViewController:webBrowser animated:YES completion:nil];
                    }
                    else if(webBrowser.mode == TSMiniWebBrowserModeNavigation) {
                        [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow];
                        [self.navigationController pushViewController:webBrowser animated:YES];
                    }
                }
            }
   
        }WithFailure:^(NSString *error){
            [DSBezelActivityView removeViewAnimated:YES];
            NSLog(@"%@",error);
        }];
    }
}

#pragma mark - TSMiniWebBrowser delegates
-(void)tsMiniWebBrowserDidDismiss
{
    [DSBezelActivityView newActivityViewForView:[UIApplication sharedApplication].keyWindow withLabel:@"Processing..."];
    NSDictionary *dictOfParameters = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[Utility getNSUserDefaultValue:KUSERID] intValue]],@"user_id",self.eventObj.eventID,@"event_id", nil];
    /**
     *  This will check, if ticket payment is successful then it return to previous page otherwise it will stay on this page.
     */
    [Utility GetDataForMethod:NSLocalizedString(@"CHECKBOOK_METHOD", @"CHECKBOOK_METHOD") parameters:dictOfParameters key:@"" withCompletion:^(id data){
        [DSBezelActivityView removeViewAnimated:YES];
        
        if ([data isKindOfClass:[NSArray class]]) {
            if ([[[data objectAtIndex:0] objectForKey:@"status"] intValue] == 1) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:[[data objectAtIndex:0] objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av setTag:99];
                [av show];
            }
            else{
                [Utility alertNotice:@"" withMSG:[[data objectAtIndex:0] objectForKey:@"message"] cancleButtonTitle:@"OK" otherButtonTitle:nil];
            }
        }
        
        if ([data isKindOfClass:[NSDictionary class]]) {
            if ([[data objectForKey:@"status"] intValue] == 1) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:[[data objectAtIndex:0] objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av setTag:99];
                [av show];
            }
            else{
                [Utility alertNotice:@"" withMSG:[data objectForKey:@"message"] cancleButtonTitle:@"ok" otherButtonTitle:nil];
            }
        }
        
    }WithFailure:^(NSString *error){
        [DSBezelActivityView removeViewAnimated:YES];
        NSLog(@"%@",error);
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99 || alertView.tag == 1001) {
        [self.eventRegisterView setHidden:YES];
    }
}

#pragma mark - Check login for MyFavourite and MyTickets
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
 *  remove login view controller
 */
-(void)dismissLoginView
{
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [self dismissViewControllerAnimated:NO completion:nil]; }
                    completion:nil];
}

#pragma mark - Table view data source
#define FEET_IN_MILES 5280
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        static NSString *CellIdentifier = @"AboutCustomCell1";
        AboutCustomCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AboutCustomCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.lblEventAddress.text   =   [NSString stringWithFormat:@"%@ %@ %@ %@",self.eventObj.eventLocationAddress,self.eventObj.eventLocationTown, self.eventObj.eventLocationState,self.eventObj.eventLocationCountry];
        cell.lblEventName.text      =   self.eventObj.eventName;
        
        CLLocation *userLocation    =   [[CLLocation alloc] initWithLatitude:[[Utility getNSUserDefaultValue:KUSERLATITUDE] floatValue] longitude:[[Utility getNSUserDefaultValue:KUSERLONGITUDE] floatValue]];
        CLLocation *eventLocation   =   [[CLLocation alloc] initWithLatitude:[self.eventObj.eventLocationLatitude floatValue] longitude:[self.eventObj.eventLocationLongitude floatValue]];
        CLLocationDistance distance =   [userLocation distanceFromLocation:eventLocation];
        
        cell.lblEventDistance.text  =   [NSString stringWithFormat:@"%f Miles",distance/FEET_IN_MILES];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if(indexPath.row==1)
    {
        static NSString *CellIdentifier = @"AboutCustomCell2";
        AboutCustomCell2 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AboutCustomCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.lblDateTime.text   =   self.eventObj.eventStartDateTime;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row==2){
        static NSString *CellIdentifier = @"AboutCustomCell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Description for event name
        
        NSString *redText = @"Description::::: \n\n";
        NSString *strDescriptionText = [self.eventObj.eventDescription stringByConvertingHTMLToPlainText];
        NSString *strDesc = [NSString stringWithFormat:@"%@%@",redText,strDescriptionText];
        
        UILabel *lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, descriptionTextHeight+20)];
        lblDescription.backgroundColor = [UIColor clearColor];
        lblDescription.numberOfLines = 0;
        lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attribs = @{NSForegroundColorAttributeName:lblDescription.textColor,
                                  NSFontAttributeName: lblDescription.font};
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:strDesc
                                               attributes:attribs];
        
        // color for Description
        NSRange redTextRange = [strDesc rangeOfString:redText];
        [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:102.0f/255.0f green:144.0f/255.0f blue:255.0f/255.0f alpha:1.0f]} range:redTextRange];
    
        NSRange grayTextRange = [strDesc rangeOfString:strDescriptionText];
        [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:127.0f/255.0f green:127.0f/255.0f blue:127.0f/255.0f alpha:1.0f], NSFontAttributeName:[UIFont systemFontOfSize:14.0f]} range:grayTextRange];
        
        lblDescription.attributedText = attributedText;
        [cell.contentView addSubview:lblDescription];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else
        return nil;
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
    switch (indexPath.row) {
        case 0:
            return 55;
            break;
        case 1:
            return 44;
            break;
        case 2:
            return descriptionTextHeight+10;
            break;
        default:
            return 44;
            break;
    }
}

#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ProgramDescriptionViewController *programDescriptionView = [segue destinationViewController];
    programDescriptionView.strDescription = self.eventObj.eventDescription;
    
}
/**
 *  Show event location on map
 */
-(void)addLocationPinOnMap
{
    self.eventLocationMapView.delegate = (id)self;
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    
    CLLocationCoordinate2D location =   CLLocationCoordinate2DMake([self.eventObj.eventLocationLatitude doubleValue], [self.eventObj.eventLocationLongitude doubleValue]);
    
    region.center = location;
    region.center.latitude  =   location.latitude;
    region.center.longitude =   location.longitude;
    region.span.longitudeDelta=0.04f;
    region.span.latitudeDelta=0.04f;
    
    [self.eventLocationMapView setRegion:region animated:YES];
    MyAnnotation *ann=[[MyAnnotation alloc]init];
    ann.title   =   self.eventObj.eventName;
    ann.subtitle=@"";
    ann.coordinate=region.center;
    [self.eventLocationMapView addAnnotation:ann];
    [self.eventLocationMapView setRegion:region animated:YES];
}

#pragma mark - MapView Delegates
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if( annotation == mapView.userLocation )
    {
        return nil;
    }
    MyAnnotation *delegate = annotation;  //THIS CAST WAS WHAT WAS MISSING!
    MKPinAnnotationView *annView = nil;
    annView = (MKPinAnnotationView*)[eventLocationMapView dequeueReusableAnnotationViewWithIdentifier:@"eventloc"];
    if( annView == nil ){
        annView = [[MKPinAnnotationView alloc] initWithAnnotation:delegate reuseIdentifier:@"eventloc"];
    }
    
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    
    return annView;
}

#pragma mark - Custom Picker and Delegates
-(void)showCustomPicker
{
    CustomPickerView *customPicker;
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        customPicker = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, size.height, 320, 250) delegate:self tag:1];
    }
    else
        customPicker = [[CustomPickerView alloc] initWithFrame:CGRectMake(0, size.height-65, 320, 250) delegate:self tag:1];
    
    [customPicker customPickerAddDataSource:self.arrayTotalSpaces component:0 defaultValue:0];
    [self.view addSubview:customPicker];
    [customPicker showCustomPickerInView:self.view];
}

-(void)customPickerValuePicked:(NSMutableDictionary *)values tag:(int)tag
{
    self.txtFieldBookingSpaces.text = [values objectForKey:@"0"];
}

-(void)customPickerDidCancel
{
    self.txtFieldBookingSpaces.text = @"";
}

#pragma Text Fields Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [txtViewComment endEditing:YES];
    [txtFieldBookingSpaces resignFirstResponder];
    
    if ([self.arrayTotalSpaces count]>0) {
        [self showCustomPicker];
    }
    else{
        [txtViewComment resignFirstResponder];
        [self.view endEditing:YES];
        [Utility alertNotice:@"" withMSG:@"Not Available" cancleButtonTitle:@"OK" otherButtonTitle:nil];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    [textView endEditing:YES];
    [txtViewComment resignFirstResponder];
    [self.eventRegisterView endEditing:YES];
    [txtViewComment endEditing:YES];
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    [textView endEditing:YES];
    [txtViewComment resignFirstResponder];
    [self.eventRegisterView endEditing:YES];
    [txtViewComment endEditing:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self.txtViewComment resignFirstResponder];
        return YES;
    }
    return YES;
}

#pragma mark - Validation check
-(BOOL)isValid
{
    if (!([self.arrayTotalSpaces count]>0)) {
        return YES;
    }
    else{
        NSString *strMessage = @"";
        if (!([self.txtFieldBookingSpaces.text length]>0)) {
            strMessage = @"Please enter Booking spaces";
        }
        else if (!([self.txtViewComment.text length]>0)){
            strMessage = @"Please enter comment";
        }
        
        if ([strMessage length]>0) {
            [Utility alertNotice:@"" withMSG:strMessage cancleButtonTitle:@"OK" otherButtonTitle:nil];
            return NO;
        }
        return YES;
    }
}

@end
