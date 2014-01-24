//
//  MFMyInvitationsViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 21/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFMyInvitationsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    IBOutlet UITableView *mainTableView;
    int deleteItem;
}
- (IBAction)menuButtonClick:(id)sender;
- (IBAction)editButtonClick:(id)sender;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@end
