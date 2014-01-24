//
//  MFRegisterViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 21/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import "MFRegisterViewController.h"
#import "MFRequest.h"

#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)

@interface MFRegisterViewController ()

@end

@implementation MFRegisterViewController

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

- (IBAction)backgroundClick:(id)sender {
    [self.passwordLabel resignFirstResponder];
    [self.confirmLabel resignFirstResponder];
    [self.emailLabel resignFirstResponder];
    [self.nameLabel resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (!IS_IPHONE5) {
        if ([textField isEqual:self.confirmLabel]) {
             [self.scrollView setContentOffset:CGPointMake(0, 20)];
        }
    }
   
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (!IS_IPHONE5) {
        if ([textField isEqual:self.confirmLabel]) {
            [self.scrollView setContentOffset:CGPointMake(0, 0)];
        }
    }
}
- (IBAction)registerClick:(id)sender {
    MFAppDelegate *appDelegate = (MFAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.internetReachability.currentReachabilityStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Problēmas ar interneta savienojumu." delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
        [alert show];
    }else{
        if ([self.passwordLabel.text length]<1 || [self.confirmLabel.text length]<1 || [self.emailLabel.text length]<1 || [self.nameLabel.text length]<1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Atstāti tukši lauki" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
            [alert show];
        }else if (![self.passwordLabel.text isEqualToString:self.confirmLabel.text]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Paroles nesakrīt" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
            [alert show];
        }else{
            [self sendData];
        }
    }
    
    
}
-(void)sendData{
    [self.registerButton setEnabled:NO];
    
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSDictionary *subDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.emailLabel.text, self.passwordLabel.text, self.confirmLabel.text, self.nameLabel.text, nil] forKeys:@[@"email", @"password", @"password_confirmation",@"name"]];
    [dict setObject:subDict forKey:@"user"];
    
    [[MFRequest alloc] do:@"register" withParams:dict onSuccess:^(NSDictionary *result) {
        [self.registerButton setEnabled:YES];
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue] == 1) {
            self.emailLabel.text = self.passwordLabel.text = self.confirmLabel.text = self.nameLabel.text = @"";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Informācija" message:@"Uz Jūsu epastu tika aizsūta apstiprinājuma vētsule. Apstipriniet no epasta vai ievadiet kodu." delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
            [alert show];
            [self performSegueWithIdentifier:@"confirmSegue" sender:self];
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Neizdevās reģistrēties" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
            [alert show];
        }
        [spinner close];
    } onFailure:^(NSDictionary *result) {
        [self.registerButton setEnabled:YES];
        NSLog(@"%@", result);
        [spinner close];        
    }];

}
@end
