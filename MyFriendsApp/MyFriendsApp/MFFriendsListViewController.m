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
	[self writeDataToTmpDataArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MFFriendsCell";
    MFFriendsCell *cell = (MFFriendsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MFPerson *person = [tmpDataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = person.name;
    cell.emailLabel.text = person.email;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tmpDataArray count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedPerson =[tmpDataArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"selectSegue" sender:self];
    
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
-(void)writeDataToTmpDataArray{
    tmpDataArray = [[NSMutableArray alloc] init];
    
    MFPerson *person = [MFPerson new];
    
    person.name = @"Aigars Mališevs";
    person.email = @"aigarsmalisevs@gmail.com";
    CLLocationCoordinate2D cord;
    cord.latitude = 56.930323;
    cord.longitude = 24.015416;
    person.coordinate = cord;
    [tmpDataArray addObject:person];
    
    person = [MFPerson new];
    person.name = @"Aigars Znotiņš";
    person.email = @"aigars.znotins@gmail.com";
    cord.latitude = 57.075629;
    cord.longitude = 24.334524;
    person.coordinate =cord;
    [tmpDataArray addObject:person];
    
    person = [MFPerson new];
    person.name = @"Klāvs Taube";
    person.email = @"klavs.taube@gmail.com";
    cord.latitude = 56.950670;
    cord.longitude = 24.103698;
    person.coordinate = cord;
    [tmpDataArray addObject:person];
    
    person = [MFPerson new];
    person.name = @"Jānis Pūgulis";
    person.email = @"janis.pugulis@gmail.com";
    cord.latitude = 56.923923;
    cord.longitude = 24.063621;
    person.coordinate = cord;
    [tmpDataArray addObject:person];
    
    person = [MFPerson new];
    person.name = @"Jānis Peisenieks";
    person.email = @"janis@peisenieks.lv";
    cord.latitude = 56.969416;
    cord.longitude = 24.122329;
    person.coordinate = cord;
    [tmpDataArray addObject:person];
    
}
@end
