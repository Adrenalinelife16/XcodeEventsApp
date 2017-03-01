//
//  RegistrationViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather & Josh Martin.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol registrationViewDelegate <NSObject>

-(void)dismissRegistrationView;

@end
@interface RegistrationViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    id<registrationViewDelegate> __unsafe_unretained delegate;
    
}

@property (assign, nonatomic) id<registrationViewDelegate> __unsafe_unretained delegate;
@property (strong, nonatomic) IBOutlet UIScrollView *scrlView;

@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirmPassword;

@property (strong, nonatomic) NSArray *countryArray;
@property (strong, nonatomic) NSString *countryName, *countryCode;

-(IBAction)btnRegisterPressed:(id)sender;
-(IBAction)backgroundTouched:(id)sender;
-(IBAction)textfieldReturn:(id)sender;

@end
