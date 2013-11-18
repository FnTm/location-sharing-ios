//
//  MFPerson.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 10/16/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MFPerson : NSObject<MKAnnotation>

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name email:(NSString*)email coordinate:(CLLocationCoordinate2D)coordinate;

@end
