//
//  MFSettingsViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 18/11/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import "MFSettingsViewController.h"
#import "MFMenuCell.h"
#import "IIViewDeckController.h"

@interface MFSettingsViewController ()

@end

@implementation MFSettingsViewController

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

- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}
//changePasswordSegue
//deleteProfileSegue
- (IBAction)changePasswordButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"changePasswordSegue" sender:self];
}

- (IBAction)deleteProfileButtonClick:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uzmanību" message:@"Vai tiešām vēlaties dzēst savu profilu?" delegate:self cancelButtonTitle:@"Atcelt" otherButtonTitles:@"Jā", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [self deleteProfile];
    }
}
-(void)deleteProfile{
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    
    [[MFRequest alloc] do:@"deleteProfile" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue] == 1) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:MF_TOKEN];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSegueWithIdentifier:@"deleteProfileSegue" sender:self];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Neizdevās dzēst profilu" delegate:self cancelButtonTitle:@"Atcelt" otherButtonTitles:@"Jā", nil];
            [alert show];
        }
        [spinner close];
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Neizdevās dzēst profilu" delegate:self cancelButtonTitle:@"Atcelt" otherButtonTitles:@"Jā", nil];
        [alert show];
        [spinner close];
    }];

}
@end
