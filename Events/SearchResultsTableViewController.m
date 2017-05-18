//
//  SearchResults.m
//  Events
//
//  Created by Michael Cather on 5/1/17.
//

#import "SearchResultsTableViewController.h"
#import "TableCellTableViewController.h"
#import "EventList.h"
#import "AboutViewController.h"


@interface SearchResultsTableViewController () <UITableViewDataSource, UITextViewDelegate>


@property (nonatomic, strong) SearchResultsTableViewController *resultsTableController;

@end

@implementation SearchResultsTableViewController
{
    
    NSMutableArray *arrayEventList;
    NSMutableArray *sortedArrayEventList;
    NSDate *eventDate;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    EventList *product = self.searchResults[indexPath.row];
    [self configureCell:cell forProduct:product];
    
    return cell;
}

@end
