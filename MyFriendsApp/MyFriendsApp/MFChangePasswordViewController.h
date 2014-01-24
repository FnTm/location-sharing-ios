//
//  MFChangePasswordViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 23/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFChangePasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;
- (IBAction)confirmButtonClick:(id)sender;

@end
