//
//  MFRequest.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 19/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^handler)(NSDictionary *result);
@interface MFRequest : NSObject<NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, strong) NSString *requestType;
@property (nonatomic, copy) handler successHandler;
@property (nonatomic, copy) handler failureHandler;

- (void) do:(NSString *)action withParams:(NSDictionary *)params onSuccess:(handler)succesHandler onFailure:(handler)failureHandler;
@end
