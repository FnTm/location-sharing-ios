//
//  MFRequest.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 19/01/14.
//  Copyright (c) 2014 Aigars Malisevs. All rights reserved.
//

#import "MFRequest.h"

@implementation MFRequest
@synthesize responseData, connection;
@synthesize requestType;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [NSMutableData new];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:@"fail" forKey:@"status"];
    self.failureHandler(dict);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSDictionary *dict;
 
    if ([responseData length] > 0) {
        dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    }else {
        dict = [NSDictionary dictionaryWithObject:@"fail" forKey:@"status"];
    }
    
    self.successHandler(dict);
    
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)theChallenge
{
    if ([theChallenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        [theChallenge.sender useCredential:[NSURLCredential credentialForTrust:theChallenge.protectionSpace.serverTrust] forAuthenticationChallenge:theChallenge];
    }
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    if([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        return YES;
    }
    return NO;
}

- (void)do:(NSString *)action withParams:(NSDictionary *)params onSuccess:(handler)succesHandler onFailure:(handler)failureHandler
{
    
    self.successHandler = succesHandler;
    self.failureHandler = failureHandler;
    
    if([action isEqualToString:@"login"]){
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.194.30.63:3000/api/v1/sessions"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    }else if([action isEqualToString:@"logout"]){
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.194.30.63:3000/api/v1/sessions"]];
        [request setHTTPMethod:@"DELETE"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"register"]){
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.194.30.63:3000/api/v1/users/"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"confirmCode"]){
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.194.30.63:3000/api/v1/users/12/confirmation"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"allFriends"]){
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.194.30.63:3000/api/v1/friends/?authentication_token=%@", [params valueForKey:MF_TOKEN]]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"invite"]){

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.194.30.63:3000/api/v1/friends/"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"deleteFriendship"]){
        
        NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://54.194.30.63:3000/api/v1/friends/%@/",[params objectForKey:@"id"]]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"DELETE"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:[params objectForKey:@"token"] options:NSJSONWritingPrettyPrinted error:&error];
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"acceptFriendship"]){
        NSString *urlStr =[NSString stringWithFormat:@"http://54.194.30.63:3000/api/v1/friends/%@/",[params objectForKey:@"id"]];
        NSURL *url = [[NSURL alloc] initWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"PUT"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:[params objectForKey:@"token"] options:NSJSONWritingPrettyPrinted error:&error];
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
      //  NSLog(@"url:%@", urlStr);
      //  NSLog(@"postSting:%@", postString);
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"sendLocation"]){
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.194.30.63:3000/api/v1/users/13/location"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"deleteProfile"]){
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.194.30.63:3000/api/v1/users/12/"]];
        [request setHTTPMethod:@"DELETE"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }else if([action isEqualToString:@"changePassword"]){
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.194.30.63:3000/api/v1/users/12/"]];
        [request setHTTPMethod:@"PUT"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString *postString=[[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }

    
}
@end
