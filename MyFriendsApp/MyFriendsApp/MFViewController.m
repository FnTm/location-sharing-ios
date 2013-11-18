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

@interface MFViewController ()

@end

@implementation MFViewController
@synthesize displayPerson;
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.displayPerson != nil) {
        [self writeSelectedToArray];
    }else{
        [self writeDataToTmpDataArray];
    }
    
    [self plotPositions];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)inviteButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"invite" sender:self];
}

- (IBAction)menuButtonClick:(id)sender {
    [self.viewDeckController toggleLeftView];
}

- (void)plotPositions{
  
    for (MFPerson *person in tmpDataArray) {
        [_mapView addAnnotation:person];
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
-(void)writeSelectedToArray{
    tmpDataArray = [[NSMutableArray alloc] init];
    [tmpDataArray addObject:displayPerson];
}

-(void)writeDataToTmpDataArray{
    tmpDataArray = [[NSMutableArray alloc] init];
    
    MFPerson *person = [MFPerson new];
  
    person.name = @"Aigars Mališevs";
    person.email = @"aigarsmalisevs@gmail.com";
    CLLocationCoordinate2D cord;
    cord.latitude = 56.930323;
    cord.longitude = 24.015416;
    person.coordinate = cord;
    [tmpDataArray addObject:person];
    
    person = [MFPerson new];
    person.name = @"Aigars Znotiņš";
    person.email = @"aigars.znotins@gmail.com";
    cord.latitude = 57.075629;
    cord.longitude = 24.334524;
    person.coordinate =cord;
    [tmpDataArray addObject:person];
    
    person = [MFPerson new];
    person.name = @"Klāvs Taube";
    person.email = @"klavs.taube@gmail.com";
    cord.latitude = 56.950670;
    cord.longitude = 24.103698;
    person.coordinate = cord;
    [tmpDataArray addObject:person];
    
    person = [MFPerson new];
    person.name = @"Jānis Pūgulis";
    person.email = @"janis.pugulis@gmail.com";
    cord.latitude = 56.923923;
    cord.longitude = 24.063621;
    person.coordinate = cord;
    [tmpDataArray addObject:person];
    
    person = [MFPerson new];
    person.name = @"Jānis Peisenieks";
    person.email = @"janis.pugulis@gmail.com";
    cord.latitude = 56.969416;
    cord.longitude = 24.122329;
    person.coordinate = cord;
    [tmpDataArray addObject:person];
   
    
}
@end
