//
//  MFRegisterViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 21/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFRegisterViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *confirmLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)backgroundClick:(id)sender;
- (IBAction)registerClick:(id)sender;
@end
