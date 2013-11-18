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
    UIAlertView *alert;
    if (_textField.text.length < 4) {
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Bad input data!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        
    }else{
        alert = [[UIAlertView alloc] initWithTitle:@"Invitation has been sent!" message:@"Invitation has been sent!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        _textField.text = @"";
    }
    [alert show];
}

- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"beidz");
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self inviteButtonClick:self];
    [textField resignFirstResponder];
    
    return YES;
}
@end
