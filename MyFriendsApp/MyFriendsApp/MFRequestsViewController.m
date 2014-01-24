//
//  MFRequestsViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 21/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import "MFRequestsViewController.h"
#import "MFMenuCell.h"
#import "IIViewDeckController.h"
#import "MFFriendsCell.h"

@interface MFRequestsViewController ()

@end

@implementation MFRequestsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];
    
    [[MFRequest alloc] do:@"allFriends" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        self.dataArray = [result objectForKey:@"inviting_friends"];
        [mainTableView reloadData];
        [spinner close];
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        [spinner close];
    }];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataArray count]<1) {
        [self.noDataLabel setHidden:NO];
    }else{
        [self.noDataLabel setHidden:YES];
    }
    
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MFFriendsCell";
    MFFriendsCell *cell = (MFFriendsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.nameLabel.text = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.emailLabel.text = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"email"];
    [cell.denyButton setTag:200+indexPath.row];
    [cell.denyButton addTarget:self action:@selector(denyClick:) forControlEvents:UIControlEventTouchDown];
    [cell.acceptButton setTag:400+indexPath.row];
    [cell.acceptButton addTarget:self action:@selector(acceptClick:) forControlEvents:UIControlEventTouchDown];
    return cell;
}
-(IBAction)denyClick:(id)sender{
   UIButton *b = (UIButton *)sender;
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[[self.dataArray objectAtIndex:b.tag-200] valueForKey:@"id"] forKey:@"id"];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    [dict setObject:dict2 forKey:@"token"];
    
    [[MFRequest alloc] do:@"deleteFriendship" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue]==1) {
            [self.dataArray removeObjectAtIndex:b.tag-200];
            [mainTableView reloadData];
        }
        [spinner close];
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        [spinner close];
    }];

}
-(IBAction)acceptClick:(id)sender{
    UIButton *b = (UIButton *)sender;
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[[self.dataArray objectAtIndex:b.tag-400] valueForKey:@"id"] forKey:@"id"];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    [dict setObject:dict2 forKey:@"token"];
    [[MFRequest alloc] do:@"acceptFriendship" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue]==1) {
            [self.dataArray removeObjectAtIndex:b.tag-400];
            [mainTableView reloadData];
        }
        [spinner close];
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        [spinner close];
    }];

    
}
- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}
@end
