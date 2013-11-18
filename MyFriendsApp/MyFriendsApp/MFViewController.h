//
//  MFViewController.h
//  MyFriendsApp
//
//  Created by Aigars Malisevs on 10/16/13.
//  Copyright (c) 2013 Aigars Malisevs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MFPerson.h"

@interface MFViewController : UIViewController<MKMapViewDelegate, UINavigationBarDelegate, UINavigationControllerDelegate>{
    NSMutableArray *tmpDataArray;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, strong) MFPerson *displayPerson;

- (IBAction)menuButtonClick:(id)sender;


@end
