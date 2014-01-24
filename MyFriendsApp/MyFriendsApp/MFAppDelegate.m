//
//  MFAppDelegate.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 10/16/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import "MFAppDelegate.h"
#import "IIViewDeckController.h"
#import "MFMenuViewController.h"

#define TEN_MIN 3.0f * 60.0f

@implementation MFAppDelegate
@synthesize locationManager, isUpdating;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN]){
        NSLog(@"Logged in with token:%@", [[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN]);
        
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mainViewController"];
        UIStoryboard *myStoryBoard =  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *center =[myStoryBoard instantiateViewControllerWithIdentifier:@"mainNavigation"];
        
        MFMenuViewController *menuController = [myStoryBoard instantiateViewControllerWithIdentifier:@"Left"];
        
        IIViewDeckController *deckController = (IIViewDeckController *)self.window.rootViewController;
        deckController.centerController = center;
        deckController.leftController = menuController;
        deckController.elastic = NO;
        deckController.rotationBehavior = IIViewDeckRotationKeepsViewSizes;
    
        [self startNavigate];
   
    }else{
        isUpdating = NO;
    }
   //sendLocation
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self stopUpdating];
    [self.internetReachability stopNotifier];
    self.internetReachability = nil;
    
}
-(void)stopUpdating{
    isUpdating = NO;
    [locationManager stopUpdatingLocation];
    locationManager = nil;
    lastUpdate = nil;
}
-(void)startNavigate{
    lastPoint = nil;
    distance = 0;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:1];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
    isUpdating = YES;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"izsaucās");
    CLLocation *newLocation = [locations lastObject];
    if ([self isValidLocation:newLocation withOldLocation:lastPoint]) {
        if (lastUpdate==nil) {
            lastUpdate = newLocation.timestamp;
            [self sendCoordinates:newLocation];
        }
        
        distance += [lastPoint distanceFromLocation:newLocation];
        lastPoint = newLocation;
        if ([newLocation.timestamp timeIntervalSinceDate:lastUpdate]>TEN_MIN) {
            //if (distance>30) {
                [self sendCoordinates:newLocation];
                distance = 0;
                lastUpdate = newLocation.timestamp;
            //}
        }

        NSLog(@"pp:%f", [newLocation.timestamp timeIntervalSinceDate:lastUpdate]);
        
    }

}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"problēmas ar locationManager:%@", error);
}

- (BOOL)isValidLocation:(CLLocation *)newLocation
        withOldLocation:(CLLocation *)oldLocation
{
    // filter out nil locations
    if (!newLocation){
        return NO;
    }
    // filter out points by invalid accuracy
    if (newLocation.horizontalAccuracy < 0){
        return NO;
    }

    if (oldLocation != nil) {
        // filter out points that are out of order
        NSTimeInterval secondsSinceLastPoint = [newLocation.timestamp
                                                timeIntervalSinceDate:oldLocation.timestamp];
        if (secondsSinceLastPoint < 0){
            return NO;
        }
        
        if ([newLocation distanceFromLocation:oldLocation] < 0){
            return NO;
        }
        
    }else{
        
    }
    
    // newLocation is good to use
    return YES;
}
-(void)sendCoordinates:(CLLocation*)location{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSString *latitudeString = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:latitudeString,longitudeString, nil] forKeys:[NSArray arrayWithObjects:@"latitude", @"longitude", nil]];
    [dict setObject:dict2 forKey:@"user"];
    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    
    [[MFRequest alloc] do:@"sendLocation" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"sendLocation:%@", result);
        
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        
    }];
}
@end
