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


//@interface SearchResultsViewController () <UITableViewDelegate,UITableViewDataSource>

//@end

@implementation SearchResultsViewController 


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
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

@end
