//
//  SearchResults.m
//  Events
//
//  Created by Michael Cather on 5/1/17.
//

#import "SearchResultsTableViewController.h"
#import "TableCellTableViewController.h"
#import "EventList.h"


@interface SearchResultsTableViewController ()
@end

@implementation SearchResultsTableViewController 


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
