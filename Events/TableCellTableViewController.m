//
//  TableCellTableViewController.m
//  Events
//
//  Created by Michael Cather on 5/15/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import "TableCellTableViewController.h"
#import "EventList.h"
#import "SearchCustomCell.h"
#import "ProgramCustomCell.h"
#import "UIImageView+WebCache.h"
#import "AboutViewController.h"
#import "SearchResultsTableViewController.h"
#import "ProgramViewController.h"

@interface TableCellTableViewController ()

@property (nonatomic, strong) SearchResultsTableViewController *resultsTableController;


@end

NSString *const kCellIdentifier = @"cellID";
NSString *const kTableCellNibName = @"TableCell";

@implementation TableCellTableViewController
{
    
    NSMutableArray *arrayEventList;
    NSMutableArray *sortedArrayEventList;
    NSDate *eventDate;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)configureCell:(ProgramCustomCell *)cell forProduct:(EventList *)obj {
    
    cell.lblDateTime.text   =   [Utility compareDates:obj.eventStartDateTime date:[NSDate date]];
    cell.lblEventName.text  =   obj.eventName;
    cell.lblEventDesc.text  =   [obj.eventDescription stringByConvertingHTMLToPlainText];
    cell.lblEventDesc.text  =   [Utility TrimString:cell.lblEventDesc.text];
    
  
    
    if ([obj.eventImageURL length]) {
        [cell.imgEventImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.eventImageURL]] placeholderImage:nil];
    }
    
    cell.imgEventImage.contentMode = UIViewContentModeScaleAspectFill;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EventList *obj = (tableView == self.tableView) ?
    self->arrayEventList[indexPath.row]: self.resultsTableController.searchResults[indexPath.row];
    
    AboutViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"aboutView"];
    detailViewController.eventObj = obj;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
