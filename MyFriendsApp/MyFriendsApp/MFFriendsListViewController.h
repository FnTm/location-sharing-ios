//
//  MFFriendsListViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 18/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFFriendsListViewController : UIViewController<UINavigationBarDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *friendsTableView;
}
- (IBAction)menuButtonClick:(id)sender;

@end
