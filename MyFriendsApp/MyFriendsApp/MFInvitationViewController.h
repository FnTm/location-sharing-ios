//
//  MFInvitationViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 10/16/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFInvitationViewController : UIViewController<UITextFieldDelegate, UINavigationBarDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)inviteButtonClick:(id)sender;
- (IBAction)menuButtonClick:(id)sender;

@end
