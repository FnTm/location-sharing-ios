//
//  MFRequestsViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 21/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFRequestsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *mainTableView;
}
- (IBAction)menuButtonClick:(id)sender;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;


@end
