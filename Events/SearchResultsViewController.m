//
//  SearchResults.m
//  Events
//
//  Created by Michael Cather on 5/1/17.
//

#import "SearchResultsViewController.h"
#import "ProgramCustomCell.h"
#import "SearchCustomCell.h"
#import "Utility.h"
#import "EventList.h"
#import "UIImageView+WebCache.h"
#import "AboutViewController.h"

@interface SearchResultsViewController () <UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *arrayEventList;
 //   IBOutlet UITableView *MyTableView;
}

@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *MyTableView;


@end

@implementation SearchResultsViewController

@synthesize searchController;

- (void)viewDidLoad
{
    [super viewDidLoad];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 162; //162
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    [self.MyTableView reloadData];
    
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"aboutViewTwo"]) {
        
        
        
        NSString * storyboardName = @"Main_iPhone";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"searchNavigation"];
        
        
        NSIndexPath *selectedRowIndex = [self.MyTableView indexPathForSelectedRow];
        AboutViewController *aboutVwController = [segue destinationViewController];
        [self.navigationController setNavigationBarHidden:NO];
        EventList *obj  =   [_searchResults objectAtIndex:selectedRowIndex.row];
        aboutVwController.eventObj  =   obj;
        
    }
    
}

@end
