//
//  MFMenuViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 13/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#define headerRowHeight 30.0f
#import "MFMenuViewController.h"
#import "MFMenuCell.h"
#import "IIViewDeckController.h"
#import "MFRequest.h"

@interface MFMenuViewController ()

@end

@implementation MFMenuViewController
@synthesize mainViewController, menuTableView;

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
    UINavigationController *mainNavigation = [[self storyboard] instantiateViewControllerWithIdentifier:@"mainNavigation"];
	mainViewController = (MFViewController *)[mainNavigation.viewControllers objectAtIndex:0];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"];
    menuItems = [[NSMutableArray alloc] initWithContentsOfFile:path];
  
    
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [menuItems count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MFMenuCell";
    MFMenuCell *cell = (MFMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.titleLabel.text = [[menuItems objectAtIndex:indexPath.row] valueForKey:@"title"];
    if ([[menuItems objectAtIndex:indexPath.row] valueForKey:@"image"]!=nil) {
        UIImage *icon = [UIImage imageNamed:[[menuItems objectAtIndex:indexPath.row] valueForKey:@"image"]];
        cell.image.image = icon;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        
        UINavigationController *center =[[self storyboard] instantiateViewControllerWithIdentifier:@"mainNavigation"];
        self.viewDeckController.centerController = center;
        [self.viewDeckController toggleLeftView];
        
    }else if (indexPath.row == 1) {
      
        UINavigationController *center =[[self storyboard] instantiateViewControllerWithIdentifier:@"friendsNavigation"];
        self.viewDeckController.centerController = center;
        [self.viewDeckController toggleLeftView];

    }else if (indexPath.row == 2) {
        
        UINavigationController *center =[[self storyboard] instantiateViewControllerWithIdentifier:@"sendNavigation"];
        self.viewDeckController.centerController = center;
        [self.viewDeckController toggleLeftView];
        
    }else if (indexPath.row == 5) {
        
        UINavigationController *center =[[self storyboard] instantiateViewControllerWithIdentifier:@"settingsNavigation"];
        self.viewDeckController.centerController = center;
        [self.viewDeckController toggleLeftView];
        
    }else if (indexPath.row == 3) {
        
        UINavigationController *center =[[self storyboard] instantiateViewControllerWithIdentifier:@"myInvitationsNavigation"];
        self.viewDeckController.centerController = center;
        [self.viewDeckController toggleLeftView];
        
    }else if (indexPath.row == 4) {
        
        UINavigationController *center =[[self storyboard] instantiateViewControllerWithIdentifier:@"invitationsNavigation"];
        self.viewDeckController.centerController = center;
        [self.viewDeckController toggleLeftView];
        
    }else if (indexPath.row == 6) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Vai tiešām vēlaties izlogoties?" delegate:self cancelButtonTitle:@"Atcelt" otherButtonTitles:@"Labi", nil];
        [alert show];
        
    }

    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc] initWithFrame:(CGRect) { 0, 0, 270, headerRowHeight}];
    view.backgroundColor = [UIColor blackColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, tableView.frame.size.width, headerRowHeight)];
    headerLabel.textColor = [UIColor grayColor];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    headerLabel.text = @"Menu";
    [view addSubview:headerLabel];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerRowHeight;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadMenuItems{
    menuItems = [NSMutableArray new];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self logoutClick];
    }
}
-(void)logoutClick{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN]==nil) {
        [self performSegueWithIdentifier:@"logoutSegue" sender:self];
        
    }else{
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
        
        [[MFRequest alloc] do:@"logout" withParams:dict onSuccess:^(NSDictionary *result) {
            NSLog(@"%@", result);
         
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:MF_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"top:%@", [[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN]);
            if ([result valueForKey:@"errors"]) {
                NSLog(@"kļūda");
            }
            [self performSegueWithIdentifier:@"logoutSegue" sender:self];
        } onFailure:^(NSDictionary *result) {
            NSLog(@"%@", result);
            
        }];

    }
    
}

@end
