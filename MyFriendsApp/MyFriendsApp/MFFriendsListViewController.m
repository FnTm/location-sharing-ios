//
//  MFFriendsListViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 18/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import "MFFriendsListViewController.h"
#import "IIViewDeckController.h"
#import "MFMenuViewController.h"
#import "MFPerson.h"
#import "MFFriendsCell.h"
#import "MFViewController.h"

@interface MFFriendsListViewController ()
@property (nonatomic, strong) NSMutableArray *tmpDataArray;
@property (nonatomic, strong) MFPerson *selectedPerson;
@end

@implementation MFFriendsListViewController
@synthesize tmpDataArray;
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
    
    [[MFRequest alloc] do:@"allFriends" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        self.dataArray = [result objectForKey:@"friends"];
        NSLog(@"dataArray:%@", self.dataArray);
        [friendsTableView reloadData];
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        
    }];

    
	//[self writeDataToTmpDataArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}

- (IBAction)editClick:(id)sender {
    if ([friendsTableView isEditing]) {
        [friendsTableView setEditing:NO];
    }else{
        [friendsTableView setEditing:YES];
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MFFriendsCell";
    MFFriendsCell *cell = (MFFriendsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.nameLabel.text = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.emailLabel.text = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"email"];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataArray count]<1) {
        [self.noDataLabel setHidden:NO];
    }else{
        [self.noDataLabel setHidden:YES];
    }
    return [self.dataArray count];
}
- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uzmanību" message:@"Vai tiešām vēlaties pārtraukt draudzību?" delegate:self cancelButtonTitle:@"Atcelt" otherButtonTitles:@"Jā", nil];
        [alert show];
        deleteItem = indexPath.row;
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"latitude"]!=[NSNull null] && [[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"longitude"]!=[NSNull null]) {
        MFPerson *person = [MFPerson new];
        person.name = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        person.email = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"email"];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"latitude"] floatValue], [[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"longitude"] floatValue]);
        person.coordinate = coord;
        
        self.selectedPerson = person;
        
        [self performSegueWithIdentifier:@"selectSegue" sender:self];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Diemžēl šai personai nevar noteikt atrasšanās vietu" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
        [alert show];
    }
    
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self deleteFriendship];
    }
}
-(void)deleteFriendship{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[[self.dataArray objectAtIndex:deleteItem] valueForKey:@"id"] forKey:@"id"];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    [dict setObject:dict2 forKey:@"token"];
    
    [[MFRequest alloc] do:@"deleteFriendship" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue]==1) {
            [self.dataArray removeObjectAtIndex:deleteItem];
            [friendsTableView reloadData];
        }
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        
    }];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIStoryboard *myStoryBoard =  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *center =[myStoryBoard instantiateViewControllerWithIdentifier:@"mainNavigation"];
    
    MFMenuViewController *menuController = [myStoryBoard instantiateViewControllerWithIdentifier:@"Left"];
    
    IIViewDeckController *deckController = (IIViewDeckController*) segue.destinationViewController;
    deckController.centerController = center;
    deckController.leftController = menuController;
    deckController.elastic = NO;
    deckController.rotationBehavior = IIViewDeckRotationKeepsViewSizes;
    
    MFViewController *viewController = (MFViewController*)[center.viewControllers objectAtIndex:0];
    viewController.displayPerson = self.selectedPerson;
}

@end
