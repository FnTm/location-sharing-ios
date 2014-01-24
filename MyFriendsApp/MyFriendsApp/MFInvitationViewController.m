//
//  MFInvitationViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 10/16/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import "MFInvitationViewController.h"
#import "IIViewDeckController.h"
#import "MFMenuViewController.h"

@interface MFInvitationViewController ()

@end

@implementation MFInvitationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
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
    
}

- (IBAction)inviteButtonClick:(id)sender {
    MFAppDelegate *appDelegate = (MFAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.internetReachability.currentReachabilityStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Problēmas ar interneta savienojumu." delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert;
        if (_textField.text.length < 4) {
            alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Bad input data!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            
        }else{
            [self sendData];
            
            // alert = [[UIAlertView alloc] initWithTitle:@"Invitation has been sent!" message:@"Invitation has been sent!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            // _textField.text = @"";
        }
        [alert show];
    }
    
    
    
}
-(void)sendData{
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:_textField.text forKey:@"email"];
    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    
    [[MFRequest alloc] do:@"invite" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue] == 1) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Paziņojums" message:@"Uzaicinājums veiksmīgi nosūtīts" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
            [alert show];
            self.textField.text = @"";
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Neizdevās nosūtīt uzaicinājumu" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
            [alert show];
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

-(void)textFieldDidEndEditing:(UITextField *)textField{
  
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self inviteButtonClick:self];
    [textField resignFirstResponder];
    
    return YES;
}
@end
