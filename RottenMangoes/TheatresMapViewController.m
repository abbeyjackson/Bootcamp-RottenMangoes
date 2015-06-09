//
//  TheatresMapViewController.m
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-30.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "TheatresMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>


@interface TheatresMapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    bool initialLocationSet;
}

@end

@implementation TheatresMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myLocation];
    
    self.theatreMapView.showsUserLocation = true;
    self.theatreMapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)myLocation{
    initialLocationSet = NO;
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    _locationManager.delegate = self;
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations firstObject];
    
    if (!initialLocationSet){
        
        MKCoordinateRegion startingRegion;
        CLLocationCoordinate2D loc = location.coordinate;
        startingRegion.center = loc;
        startingRegion.span.latitudeDelta = 0.02;
        startingRegion.span.longitudeDelta = 0.02;
        [self.theatreMapView setRegion:startingRegion];
        
        initialLocationSet = YES;
    }
    
    if (self.geocoder == nil){
        self.geocoder = [[CLGeocoder alloc] init];
    }
    if ([self.geocoder isGeocoding]){
        [self.geocoder cancelGeocode];
    }
    
    CLLocation *newLocation = [locations lastObject];
    [self.geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *locations, NSError *error) {
        if ([locations count] > 0){
            self.currentLocation = [locations objectAtIndex: 0];
            NSLog(@"You are in %@", self.currentLocation.subLocality);
            
            
        }
        else if (error.code == kCLErrorGeocodeCanceled){
            NSLog(@"Geocoding cancelled");
        }
        else if (error.code == kCLErrorGeocodeFoundNoResult){
            NSLog(@"No geocode result found");
        }
        else if (error.code == kCLErrorGeocodeFoundPartialResult){
            NSLog(@"Partial geocode result");
        }
        else{
            NSLog(@"Unknown error: %@", error.description);
        }
    }];
    [manager stopUpdatingLocation];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
