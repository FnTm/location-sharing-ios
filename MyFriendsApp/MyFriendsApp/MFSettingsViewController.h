//
//  MFSettingsViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 18/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFSettingsViewController : UIViewController<UINavigationBarDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
- (IBAction)menuButtonClick:(id)sender;
- (IBAction)changePasswordButtonClick:(id)sender;
- (IBAction)deleteProfileButtonClick:(id)sender;

@end
