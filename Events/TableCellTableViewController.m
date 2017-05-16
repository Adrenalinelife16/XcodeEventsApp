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


NSString *const kCellIdentifier = @"cellID";
NSString *const kTableCellNibName = @"TableCell";

@implementation TableCellTableViewController 

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

@end
