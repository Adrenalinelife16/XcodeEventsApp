//
//  SearchResults.h
//  Events
//
//  Created by Michael Cather on 5/1/17.
//

#import <UIKit/UIKit.h>

@interface SearchResultsViewController : UIViewController // UISearchContainerViewController

@property (nonatomic, strong) UISearchController *searchController;
@property (strong, nonatomic) IBOutlet UITableView *MyTableView;

@end
