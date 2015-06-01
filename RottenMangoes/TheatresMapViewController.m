//
//  TheatresMapViewController.m
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-30.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "TheatresMapViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface TheatresMapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    bool initialLocationSet;
}

@end

@implementation TheatresMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    initialLocationSet = NO;
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
    _locationManager.delegate = self;
    
    
    //    MKPointAnnotation *marker=[[MKPointAnnotation alloc] init];
    //    CLLocationCoordinate2D iansApartmentLocation;
    //    iansApartmentLocation.latitude = 49.268950;
    //    iansApartmentLocation.longitude = -123.153739;
    //    marker.coordinate = iansApartmentLocation;
    //    marker.title = @"Ian's Apartment";
    
    //    [self.mapView addAnnotation:marker];
    
    self.theatreMapView.showsUserLocation = true;
    self.theatreMapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
