//
//  MFLoginViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 12/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MFLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;



- (IBAction)loginClick:(id)sender;

@end
