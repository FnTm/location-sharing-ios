//
//  MFLoginViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 12/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import "MFLoginViewController.h"
#import "MFMenuViewController.h"
#import "IIViewDeckController.h"

@interface MFLoginViewController ()

@end

@implementation MFLoginViewController

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
  
  
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
    
   
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
}
@end
