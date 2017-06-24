//
//  SearchResults.m
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
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
