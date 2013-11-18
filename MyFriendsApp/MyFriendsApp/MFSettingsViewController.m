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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}
@end
