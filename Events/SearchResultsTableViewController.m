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
#import "AboutViewController.h"
#import "SearchSegue.h"

@interface SearchResultsTableViewController () <UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *arrayEventList;
}

@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad
    {
    [super viewDidLoad];
        
        NSString * storyboardName = @"Main_iPhone";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"searchNavigation"];
        
        
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
    return 155; //162
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
    [self.tableView reloadData];
     
}



#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"aboutViewTwo"]) {
    
        
        NSString * storyboardName = @"Main_iPhone";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"searchNavigation"];
        
        
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        AboutViewController *aboutVwController = [segue destinationViewController];
        [self.navigationController setNavigationBarHidden:NO];
        EventList *obj  =   [_searchResults objectAtIndex:selectedRowIndex.row];
        aboutVwController.eventObj  =   obj;
        
    }
    
}

@end
