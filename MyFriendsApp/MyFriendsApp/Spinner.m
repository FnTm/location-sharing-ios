//
//  Spinner.m
//  Roche
//
//  Created by DIDZIS ANDERSONS on 10/16/13.
//  Copyright (c) 2013 AmberPhone. All rights reserved.
//

#import "Spinner.h"
#import <QuartzCore/QuartzCore.h>

@implementation Spinner
@synthesize isSpinning;

-(void) showInView:(UIView *)view{
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(view.bounds.size.width/2-100, view.bounds.size.height/2-80, 200, 100)];
    backgroundView.backgroundColor = [UIColor blackColor];
    [backgroundView.layer setCornerRadius:9.0f];
    [backgroundView.layer setMasksToBounds:YES];
    
    [backgroundView setAlpha:0.8f];
    
    [view addSubview:backgroundView];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [view addSubview:activityIndicator];
    activityIndicator.center = CGPointMake(view.bounds.size.width/2-60, view.bounds.size.height/2-30);
    [activityIndicator startAnimating];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(view.bounds.size.width/2-30, view.bounds.size.height/2-70, 150, 80)];
    [label setText:@"Loading"];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [view addSubview:label];
    isSpinning = YES;
}
-(void) close{
    
    [backgroundView removeFromSuperview];
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    [label removeFromSuperview];
    backgroundView = nil;
    label = nil;
    activityIndicator = nil;
    
    isSpinning = NO;
}

@end
