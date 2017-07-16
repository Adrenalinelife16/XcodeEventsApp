//
//  LoginViewController.h
//  Events
//
//  Created by Chazz Romeo, Michael Cather.
//  Copyright (c) 2017 Adrenaline Life. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"

@protocol loginViewDelegate <NSObject>

-(void)dismissLoginView;

@end

@interface LoginViewController : UIViewController<UITextFieldDelegate,registrationViewDelegate,UIAlertViewDelegate>
{
    id<loginViewDelegate> __unsafe_unretained delegate;
}

@property(nonatomic,assign) id<loginViewDelegate> __unsafe_unretained delegate;


@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (nonatomic,strong) NSString *getDetails;

-(IBAction)btnLoginPressed:(id)sender;
//-(IBAction)btnRegistrationPressed:(id)sender;
-(IBAction)forgotPasswordPressed:(id)sender;


-(IBAction)backgroundTouched:(id)sender;
-(IBAction)textfieldReturn:(id)sender;



@end
