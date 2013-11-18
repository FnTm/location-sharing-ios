//
//  MFPerson.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 10/16/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import "MFPerson.h"
#import <AddressBook/AddressBook.h>

@implementation MFPerson

- (id)initWithName:(NSString*)name email:(NSString*)email coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([name isKindOfClass:[NSString class]]) {
            self.name = name;
        } else {
            self.name = @"Unknown charge";
        }
        self.email = email;
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _email;
}

- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}

@end
