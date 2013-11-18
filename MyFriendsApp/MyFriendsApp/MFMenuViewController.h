//
//  MFMenuViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 13/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFViewController.h"

@interface MFMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{

    MFViewController *mainViewController;
    NSMutableArray *menuItems;
}
@property(nonatomic, strong) MFViewController *mainViewController;
@property(nonatomic, strong) IBOutlet UITableView *menuTableView;

@end
