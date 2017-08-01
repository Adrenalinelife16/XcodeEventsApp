//
//  AboutViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreText/CoreText.h>
#import "EventList.h"
#import "LoginViewController.h"
#import "TSMiniWebBrowser.h"

#import "CustomPickerView.h"

@interface AboutViewController : ViewController<loginViewDelegate,UITextFieldDelegate,UITextViewDelegate,TSMiniWebBrowserDelegate,CustomPickerDelegate,UIAlertViewDelegate>{
    __weak IBOutlet UIView *vwFreeRegisterBtn;
}


@property (strong, nonatomic) IBOutlet MKMapView *eventLocationMapView;
@property (strong, nonatomic) EventList *eventObj;
@property (strong, nonatomic) IBOutlet UITableView *tblView;

@property (strong, nonatomic) IBOutlet UIView *eventRegisterView;
@property (strong, nonatomic) IBOutlet UITextField *txtFieldBookingSpaces;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalCost, *lblComment;
@property (strong, nonatomic) IBOutlet UITextView *txtViewComment;
@property (nonatomic, retain) NSString *titleText;

@property (strong, nonatomic) NSMutableArray *arrayTotalSpaces;

-(IBAction)btnSubmitPressed:(id)sender;

-(IBAction)btnCancelPressed:(id)sender;

- (IBAction)addressClicked:(id)sender;

//-(IBAction)btnEventRegistrationPressed:(id)sender;



@end
