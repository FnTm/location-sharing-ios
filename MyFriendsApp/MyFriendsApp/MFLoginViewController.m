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
#import "MFRequest.h"


@interface MFLoginViewController ()

@end

@implementation MFLoginViewController
@synthesize passwordLabel, usernameLabel;
- (void)viewDidLoad
{

    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"token:%@", [[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender {
    MFAppDelegate *appDelegate = (MFAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.internetReachability.currentReachabilityStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Problēmas ar interneta savienojumu." delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
        [alert show];
    }else{
        if ([usernameLabel.text length]<3 || [passwordLabel.text length]<3) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Nederīgi ievaddati" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
            [alert show];
        }else{
            [self sendLoginInformation];
        }
    }
    
    
}

- (IBAction)registerClick:(id)sender {
    [self performSegueWithIdentifier:@"registerSegue" sender:self];
}

- (IBAction)backgroundClick:(id)sender {
    [passwordLabel resignFirstResponder];
    [usernameLabel resignFirstResponder];
}
-(void)sendLoginInformation{
   
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSDictionary *subDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:usernameLabel.text, passwordLabel.text, nil] forKeys:@[@"email", @"password"]];
    [dict setObject:subDict forKey:@"user"];
    
    [[MFRequest alloc] do:@"login" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue] == 1) {
            [[NSUserDefaults standardUserDefaults] setValue:[result valueForKey:MF_TOKEN] forKey:MF_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
        [spinner close];
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        [spinner close];
    }];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"loginSegue"]) {
        UIStoryboard *myStoryBoard =  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *center =[myStoryBoard instantiateViewControllerWithIdentifier:@"mainNavigation"];
        
        MFMenuViewController *menuController = [myStoryBoard instantiateViewControllerWithIdentifier:@"Left"];
        
        IIViewDeckController *deckController = (IIViewDeckController*) segue.destinationViewController;
        deckController.centerController = center;
        deckController.leftController = menuController;
        deckController.elastic = NO;
        deckController.rotationBehavior = IIViewDeckRotationKeepsViewSizes;
    }
    
}
@end
