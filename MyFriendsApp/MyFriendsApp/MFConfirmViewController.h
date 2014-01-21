//
//  MFConfirmViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 21/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFConfirmViewController : UIViewController
- (IBAction)backgroundClick:(id)sender;
- (IBAction)confirmClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@end
