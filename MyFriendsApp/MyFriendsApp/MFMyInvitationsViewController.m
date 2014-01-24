//
//  MFMyInvitationsViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 21/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import "MFMyInvitationsViewController.h"
#import "MFMenuCell.h"
#import "IIViewDeckController.h"
#import "MFFriendsCell.h"
@interface MFMyInvitationsViewController ()

@end

@implementation MFMyInvitationsViewController

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
    
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];

    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    
    [[MFRequest alloc] do:@"allFriends" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        self.dataArray = [result objectForKey:@"invited_friends"];
        [mainTableView reloadData];
        [spinner close];
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        [spinner close];
    }];
	// Do any additional setup after loading the view.
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
    
    return cell;
}
- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uzmanību" message:@"Vai tiešām vēlaties atcelt uzaicinājumu?" delegate:self cancelButtonTitle:@"Nē" otherButtonTitles:@"Jā", nil];
        [alert show];
        deleteItem = indexPath.row;
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self deleteRequest];
    }
}
-(void)deleteRequest{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[[self.dataArray objectAtIndex:deleteItem] valueForKey:@"id"] forKey:@"id"];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    [dict setObject:dict2 forKey:@"token"];
    
    [[MFRequest alloc] do:@"deleteFriendship" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue]==1) {
            [self.dataArray removeObjectAtIndex:deleteItem];
            [mainTableView reloadData];
        }
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        
    }];
}
- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}

- (IBAction)editButtonClick:(id)sender {
    if ([mainTableView isEditing]) {
        [mainTableView setEditing:NO];
    }else{
        [mainTableView setEditing:YES];
    }
}
@end
