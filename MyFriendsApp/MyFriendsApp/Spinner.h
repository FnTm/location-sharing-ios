//
//  Spinner.h
//  Roche
//
//  Created by DIDZIS ANDERSONS on 10/16/13.
//  Copyright (c) 2013 AmberPhone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Spinner : NSObject{
    UIView *backgroundView;
    UIView *modalView;
    UIActivityIndicatorView *activityIndicator;
    UILabel *label;
}

@property (nonatomic) BOOL isSpinning;
-(void) showInView:(UIView *)view;
-(void) close;
@end
