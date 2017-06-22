//
//  FeedViewController.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedCustomCell.h"
#import "SecondFeedCustomCell.h"
#import "ThirdFeedCustomCell.h"
#import "Feeds.h"
#import "UIImageView+WebCache.h"
#import "FeedDetailViewController.h"

@interface FeedViewController ()
{
    NSMutableArray *    arrayOfFeeds;
    NSMutableArray *    sortedEventArray;
}

- (IBAction)Refresh:(UIRefreshControl *)sender;

@end

@implementation FeedViewController

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

    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7"))
    {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationItem.title = @"Social Feed";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [Utility afterDelay:0.01 withCompletion:^{
    [DSBezelActivityView newActivityViewForView:self.view.window];
    [self getFeedsFromServer];
    //[self sortSocialFeedFilter];
    //[self sortSocialFeed];
        
        
//  Uncomment after BETA release
        
//        [self checkLogin];
        
    }];
    
}


- (IBAction)Refresh:(UIRefreshControl *)sender
{
        // Reload the data.
        [self getFeedsFromServer];
        
        // Reload the table data with the new data
        [self.tableView reloadData];
        
        // Restore the view to normal
        [sender endRefreshing];
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/**
 *  getFeedsFromServer Method
 *
 *  @return It will get the feeds data from the server and store all feeds data in Feeds modal class.
 */
#pragma mark - Get Twitter & Facebook Feeds From Server
-(void)getFeedsFromServer
{
    NSDictionary *dictOfEventRequestParameter = [[NSDictionary alloc] init];
    
    [Utility GetDataForMethod:NSLocalizedString(@"GETFEEDS_METHOD", @"GETFEEDS_METHOD") parameters:dictOfEventRequestParameter key:@"" withCompletion:^(id response){ [DSBezelActivityView removeViewAnimated:NO];
        
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *dictTemp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:response,@"array",nil];
            NSMutableArray *arrayFBfeedsTemp = [[NSMutableArray alloc] initWithArray:[[dictTemp objectForKey:@"array"] objectForKey:@"fb_feeds"]];
            NSMutableArray *arrayTwitterFeedsTemp = [[NSMutableArray alloc] initWithArray:[[dictTemp objectForKey:@"array"] objectForKey:@"twitter_feeds"]];
            NSMutableArray *arrayInstagramFeedsTemp = [[NSMutableArray alloc] initWithArray:[[dictTemp objectForKey:@"array"] objectForKey:@"instagram_feeds"]];
           
            
            NSMutableArray  *arrayTempFeeds =   [[NSMutableArray alloc] init];
            
            /*
            
            for (NSMutableDictionary *dictFBfeeds in arrayFBfeedsTemp) {
                NSString *strTemp   =   [dictFBfeeds objectForKey:@"created_time"];
                [dictFBfeeds removeObjectForKey:@"created_time"];
                [dictFBfeeds setObject:[Utility getFormatedDateString:strTemp dateFormatString:@"yyyy-MM-dd'T'HH:mm:ssZZ" dateFormatterString:@"E, MMM d yyyy hh:mm a"] forKey:@"created_at"];
                [arrayTempFeeds addObject:dictFBfeeds];
            }
             
             
            
            for (NSMutableDictionary *dictTwitterFeeds in arrayTwitterFeedsTemp) {
                
                NSString *strTemp   =   [dictTwitterFeeds objectForKey:@"created_time"];
                [dictTwitterFeeds removeObjectForKey:@"created_time"];
                [dictTwitterFeeds setObject:[Utility getFormatedDateString:strTemp dateFormatString:@"EEE MMM dd HH:mm:ss ZZ yyyy" dateFormatterString:@"E, MMM d yyyy hh:mm a"] forKey:@"created_at"];
                [arrayTempFeeds addObject:dictTwitterFeeds];
            }
             
            */
             
            for (NSMutableDictionary *dictOfInstagramFeeds in arrayInstagramFeedsTemp) {;
                
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dictOfInstagramFeeds objectForKey:@"created_time"] doubleValue]];
                [dictOfInstagramFeeds removeObjectForKey:@"created_time"];
                NSString *strDateTime = [Utility getFormatedDateString:[NSString stringWithFormat:@"%@",date] dateFormatString:@"yyyy-MM-dd HH:mm:ss ZZ" dateFormatterString:@"E, MMM d yyyy hh:mm a"];
                [dictOfInstagramFeeds setObject:strDateTime forKey:@"created_at"];
                                
                
                [arrayTempFeeds addObject:dictOfInstagramFeeds];
            }
            
            
            
            arrayOfFeeds    =   [[NSMutableArray alloc] init];
            for (NSDictionary *dictOfFeeds in arrayTempFeeds) {
                Feeds *feedsObj     =   [[Feeds alloc] init];
                
    
                
                if ([[dictOfFeeds allKeys] containsObject:@"images"]) {
                    
            //        feedsObj.instagramThumbnail     =   [NSString stringWithFormat:@"%@",[[dictOfFeeds objectForKey:@"images"] objectForKey:@"standard_resolution"]];
                    feedsObj.instagramThumbnail     =   [[[dictOfFeeds objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
                    feedsObj.instagramDateTime      =   [dictOfFeeds objectForKey:@"created_at"];
                    feedsObj.instagramLink          =   [dictOfFeeds objectForKey:@"link"];
                    feedsObj.instagramDescription   =   [dictOfFeeds objectForKey:@"text"];
                    feedsObj.instagramTitle         =   [[dictOfFeeds objectForKey:@"user"] objectForKey:@"full_name"];
                
                
                }
                else if ([[dictOfFeeds allKeys] containsObject:@"user"]) {
                    NSDictionary *dictOfTwitterUser = [[NSDictionary alloc] initWithDictionary:[dictOfFeeds objectForKey:@"user"]];
                    
                    feedsObj.tweetDateTime    =   [dictOfFeeds objectForKey:@"created_at"];
                    feedsObj.tweetText        =   [dictOfFeeds objectForKey:@"text"];
                    feedsObj.tweetURL         =   [dictOfFeeds objectForKey:@"tweet_url"];
                    
                    feedsObj.tweetUserDescription     =   [dictOfTwitterUser objectForKey:@"description"];
                    feedsObj.tweetUserLocation        =   [dictOfTwitterUser objectForKey:@"location"];
                    feedsObj.tweetUserName            =   [dictOfTwitterUser objectForKey:@"name"];
                    feedsObj.tweetUserProfileImage    =   [dictOfTwitterUser objectForKey:@"profile_image_url"];
                    feedsObj.tweetUserScreenName      =   [dictOfTwitterUser objectForKey:@"screen_name"];
                    feedsObj.tweetUserURL             =   [dictOfTwitterUser objectForKey:@"url"];
                }
                else{
                    feedsObj.facebookDateTime   =   [dictOfFeeds objectForKey:@"created_at"];
                    feedsObj.facebookLink       =   [dictOfFeeds objectForKey:@"link"];
                    feedsObj.facebookMessage    =   [dictOfFeeds objectForKey:@"message"];
                    feedsObj.facebookPicture    =   [dictOfFeeds objectForKey:@"picture"];
                }
                [arrayOfFeeds addObject:feedsObj];
            
                
                
            }
            [self.tableView reloadData];
        }
    }WithFailure:^(NSString *error)
     {
         [DSBezelActivityView removeViewAnimated:NO];
         NSLog(@"%@",error);
     }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return arrayOfFeeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedCustomCell";
    FeedCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[FeedCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Feeds *feedsObj =   [arrayOfFeeds objectAtIndex:indexPath.row];
    
    if ([feedsObj.instagramDateTime length]>0) {
        cell.lblUserName.text       =   feedsObj.instagramTitle;
        cell.lblDateTime.text    =   [Utility compareDates:feedsObj.instagramDateTime date:[NSDate date]];
        if ([feedsObj.instagramDescription isKindOfClass:[NSNull class]]) {
            cell.lblTweet.text      =   @"";
        }
        
        else
            cell.lblTweet.text          =   feedsObj.instagramDescription;
        [cell.imgVWIcon setImage:[UIImage imageNamed:@"icon-feed-instagram.png"]];
        [cell.imgMainImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",feedsObj.instagramThumbnail]] placeholderImage:[UIImage imageNamed:@"event-feed-mask.png"]];
        
    }
    
    else if ([feedsObj.tweetUserName length]>0) {
        
        cell.lblUserName.text       =   feedsObj.tweetUserName;
        cell.lblDateTime.text    =   [Utility compareDates:feedsObj.tweetDateTime date:[NSDate date]];
        cell.lblTweet.text          =   feedsObj.tweetText;
        [cell.imgVWIcon setImage:[UIImage imageNamed:@"icon-feed-twitter.png"]];
        [cell.imgMainImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",feedsObj.tweetUserProfileImage] ] placeholderImage:[UIImage imageNamed:@"event-feed-mask.png"]];
    }
    /*
    else{
        
        cell.lblUserName.text       =   @"";
        cell.lblTweet.text          =   feedsObj.facebookMessage;
        cell.lblDateTime.text    =   [Utility compareDates:feedsObj.facebookDateTime date:[NSDate date]];
        [cell.imgVWIcon setImage:[UIImage imageNamed:@"icon-feed-facebook.png"]];
        [cell.imgMainImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",feedsObj.facebookPicture] ] placeholderImage:[UIImage imageNamed:@"event-feed-mask.png"]];
    }
     */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    FeedDetailViewController *feedDetailVwController = [segue destinationViewController];
    Feeds *obj  =   [arrayOfFeeds objectAtIndex:selectedRowIndex.row];
    if ([obj.instagramDateTime length]>0) {
        feedDetailVwController.strFeedURL   =   [NSString stringWithFormat:@"%@",obj.instagramLink];
    }
    else if ([obj.tweetUserName length]>0) {
        feedDetailVwController.strFeedURL   =   [NSString stringWithFormat:@"%@",obj.tweetURL];
    }
    else{
        feedDetailVwController.strFeedURL   =   [NSString stringWithFormat:@"%@",obj.facebookLink];
    }
}

@end
