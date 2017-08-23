//
//  PopUpViewController.h
//  Adrenaline Life
//
//  Created by Michael Cather on 8/11/17.
//  Copyright © 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpViewController : UIViewController
{
    NSMutableArray *daysOfWeek;
}




@property (strong, nonatomic) IBOutlet UITableView *tblPopUp;

-(IBAction)dismissPopup:(id)sender;



@end
