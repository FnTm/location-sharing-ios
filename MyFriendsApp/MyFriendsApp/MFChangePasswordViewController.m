//
//  MFChangePasswordViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 23/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import "MFChangePasswordViewController.h"
#import "Reachability.h"
@interface MFChangePasswordViewController ()

@end

@implementation MFChangePasswordViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmButtonClick:(id)sender {
    MFAppDelegate *appDelegate = (MFAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.internetReachability.currentReachabilityStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Problēmas ar interneta savienojumu." delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
        [alert show];
    }else{
        if ([self testTextField]) {
            UIButton *b = (UIButton *)sender;
            [b setEnabled:NO];
            
            Spinner *spinner = [Spinner new];
            [spinner showInView:self.view];
            
            
            NSMutableDictionary *dict = [NSMutableDictionary new];
            NSMutableDictionary *dict2 = [NSMutableDictionary new];
            [dict2 setObject:self.oldTextField.text forKey:@"current_password"];
            [dict2 setObject:self.passwordTextField.text forKey:@"password"];
            [dict2 setObject:self.confirmTextField.text forKey:@"password_confirmation"];
            [dict setObject:dict2 forKey:@"user"];
            [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
            
            [[MFRequest alloc] do:@"changePassword" withParams:dict onSuccess:^(NSDictionary *result) {
                NSLog(@"%@", result);
                if ([[result valueForKey:@"success"] integerValue] == 1) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Paziņojums" message:@"Parole veiksmīgi nomainīta" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
                    [alert show];
                    [b setEnabled:YES];
                    [spinner close];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    NSMutableString *errorString = [NSMutableString new];
                    if ([result objectForKey:@"errors"]) {
                        
                        if ([[result objectForKey:@"errors"] valueForKey:@"current_password"]) {
                            if ([errorString length]>0) {
                                [errorString appendString:@"\n"];
                            }
                            [errorString appendString:[NSString stringWithFormat:@"Current password %@", [[[result objectForKey:@"errors"] valueForKey:@"current_password"] objectAtIndex:0]]];
                        }
                        if ([[result objectForKey:@"errors"] valueForKey:@"password"]) {
                            if ([errorString length]>0) {
                                [errorString appendString:@"\n"];
                            }
                            [errorString appendString:[NSString stringWithFormat:@"Password %@", [[[result objectForKey:@"errors"] valueForKey:@"password"] objectAtIndex:0]]];
                        }
                        if ([[result objectForKey:@"errors"] valueForKey:@"password_confirmation"]) {
                            if ([errorString length]>0) {
                                [errorString appendString:@"\n"];
                            }
                            [errorString appendString:[NSString stringWithFormat:@"Password confirmation %@", [[[result objectForKey:@"errors"] valueForKey:@"password_confirmation"] objectAtIndex:0]]];
                        }
                        
                    }
                    if ([errorString length]>0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Kļūda" message:errorString delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
                        [alert show];
                    }
                    [b setEnabled:YES];
                    [spinner close];
                }
                [b setEnabled:YES];
                [spinner close];
            } onFailure:^(NSDictionary *result) {
                NSLog(@"%@", result);
                [b setEnabled:YES];
                [spinner close];
            }];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Nepareizi aizpildīti dati" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
            [alert show];
        }

    }
    
    
   }
//{"user":{"current_password":"password","password":"password1","password_confirmation":"password1"},"authentication_token":"F16bWKXi8GY6Wx_esjuh"}
-(BOOL)testTextField{
    if ([self.confirmTextField.text length]>5 && [self.passwordTextField.text length]>5 && [self.oldTextField.text length]>5) {
        if ([self.passwordTextField.text isEqualToString:self.confirmTextField.text]) {
            return YES;
        }
    }
    return NO;
}
@end
