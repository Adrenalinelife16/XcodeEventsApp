//
//  FavoritesTableViewController.h
//  Events
//
//  Created by Michael Cather on 6/28/17.
//  Copyright © 2017 Teknowledge Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIImageView *imgSegmentBar;
@property (strong, nonatomic) IBOutlet UIButton *btnMyTickets;
@property (strong, nonatomic) IBOutlet UIButton *btnMyFavourites;
@property (strong, nonatomic) IBOutlet UIButton *btnMyCalender;



@property (strong, nonatomic) NSMutableArray *arrayFavEvent;

@property (strong, nonatomic) IBOutlet UITableView *tblFavTable;


- (IBAction)clickedMyAttending:(id)sender;

- (IBAction)clickedMyFavourites:(id)sender;

- (IBAction)clickedMyCalender:(id)sender;


@end
