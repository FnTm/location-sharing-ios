//
//  MFFriendsListViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 18/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFFriendsListViewController : UIViewController<UINavigationBarDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    IBOutlet UITableView *friendsTableView;
    int deleteItem;
}
@property(nonatomic, strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;
- (IBAction)menuButtonClick:(id)sender;
- (IBAction)editClick:(id)sender;

@end
