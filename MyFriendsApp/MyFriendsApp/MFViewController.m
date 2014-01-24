//
//  MFViewController.m
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 10/16/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import "MFViewController.h"
#import "MFPerson.h"
#import "IIViewDeckController.h"
#import "MFMenuViewController.h"
#import "MFAppDelegate.h"

@interface MFViewController ()

@end

@implementation MFViewController
@synthesize displayPerson;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.displayPerson != nil) {
        [self loadSelected];
    }else{
        [self loadData];
    }
    MFAppDelegate *appDelegate = (MFAppDelegate*)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.isUpdating) {
        [appDelegate startNavigate];
    }
}
-(void)loadSelected{
    dataArray = [NSMutableArray new];
    [dataArray addObject:displayPerson];
    [self plotPositions];
}
-(void)loadData{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[[NSUserDefaults standardUserDefaults] valueForKey:MF_TOKEN] forKey:MF_TOKEN];
    Spinner *spinner = [Spinner new];
    [spinner showInView:self.view];
    [[MFRequest alloc] do:@"allFriends" withParams:dict onSuccess:^(NSDictionary *result) {
        NSLog(@"%@", result);
        if ([[result valueForKey:@"errors"] count] < 1) {
            dataArray = [NSMutableArray new];
            NSArray *arr = [result objectForKey:@"friends"];
            for (NSDictionary *object in arr) {
                if ([object valueForKey:@"latitude"]!=[NSNull null] && [object valueForKey:@"longitude"]!=[NSNull null]) {
                    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[object valueForKey:@"latitude"] floatValue], [[object valueForKey:@"longitude"] floatValue]);
                    MFPerson *person = [[MFPerson alloc] initWithName:[object valueForKey:@"name"] email:[object valueForKey:@"email"] coordinate:coord];
                    [dataArray addObject:person];
                }
            }

            [self plotPositions];
        }
        [spinner close];
    } onFailure:^(NSDictionary *result) {
        NSLog(@"%@", result);
        [spinner close];
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}

- (IBAction)refreshClick:(id)sender {
    [self loadData];
}

- (void)plotPositions{
  
    for (MFPerson *person in dataArray) {
        if (person.coordinate.latitude) {
            [_mapView addAnnotation:person];
        }
        
    }
    CLLocationCoordinate2D startCoord;
    if (displayPerson != nil) {
        startCoord = displayPerson.coordinate;
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 300, 300)];
        [_mapView setRegion:adjustedRegion animated:YES];
    }else{
        startCoord = CLLocationCoordinate2DMake(56.950670, 24.103698);
        MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 30000, 30000)];
        [_mapView setRegion:adjustedRegion animated:YES];
    }
   
    
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *identifier = @"MFPerson";
    if ([annotation isKindOfClass:[MFPerson class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"greenDot.png"];
        }else{
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

@end
