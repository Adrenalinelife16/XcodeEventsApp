//
//  SearchResults.h
//  Events
//
//  Created by Michael Cather on 5/1/17.
//

#import <UIKit/UIKit.h>

@interface SearchResultsViewController : UISearchContainerViewController

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *MyTableView;

@end
