//
//  MFAppDelegate.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 10/16/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"

@interface MFAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>{
    CLLocation *lastPoint;
    NSInteger distance;
    NSDate *lastUpdate;
}

-(void)startNavigate;
-(void)stopUpdating;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic)BOOL isUpdating;

@property (nonatomic) Reachability *internetReachability;

@end
