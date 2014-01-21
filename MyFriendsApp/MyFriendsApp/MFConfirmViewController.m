//
//  MFConfirmViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 21/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import "MFConfirmViewController.h"
#import "MFRequest.h"

@interface MFConfirmViewController ()

@end

@implementation MFConfirmViewController

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
    [self.codeTextField resignFirstResponder];
}

- (IBAction)confirmClick:(id)sender {
    if ([self.codeTextField.text length]<7) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problēma" message:@"Par maz simbolu" delegate:self cancelButtonTitle:@"Labi" otherButtonTitles:nil];
        [alert show];
    }else{
        [self loadData];
    }
}
-(void)loadData{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.codeTextField.text forKey:@"confirmation_token"];
    [self.confirmButton setEnabled:NO];
    [[MFRequest alloc] do:@"confirmCode" withParams:dict onSuccess:^(NSDictionary *result) {
        [self.confirmButton setEnabled:YES];
        NSLog(@"%@", result);
        if ([[result valueForKey:@"success"] integerValue] == 1) {
            [self performSegueWithIdentifier:@"backToLoginSegue" sender:self];
        }
        
    } onFailure:^(NSDictionary *result) {
        [self.confirmButton setEnabled:YES];
        NSLog(@"%@", result);
        
    }];

}
@end
