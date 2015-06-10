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
#import "Movie.h"
#import "Theatre.h"

@interface TheatresMapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    bool initialLocationSet;
}

@end

@implementation TheatresMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self myLocation];
    
    self.theatreArray = [NSMutableArray array];
    self.theatreMapView.showsUserLocation = true;
    self.theatreMapView.delegate = self;
    self.annotation = [[MKPointAnnotation alloc]init];
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(49.2789976, -123.0963081);
    myAnnotation.title = @"Matthews Pizza";
    myAnnotation.subtitle = @"Best Pizza in Town";
    
//    [self.theatreMapView addAnnotation:myAnnotation];

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
                
        [self getNearbyTheatres:locations];

    }
    
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKAnnotationView* annotationView = [mapView viewForAnnotation:userLocation];
    annotationView.canShowCallout = NO;
}



-(void)getNearbyTheatres:(NSArray*)locations{
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
            
            NSString *lighthouseURL = @"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json";
            NSString *userPostalCode = [self.currentLocation.postalCode stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString *movieTitle = [self.movie.movieTitle stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSString *urlString = [NSString stringWithFormat:@"%@?address=%@&movie=%@", lighthouseURL, userPostalCode, movieTitle];
            NSURL *url = [NSURL URLWithString:urlString];
            
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            
            __weak typeof(self)weakSelf = self;
            NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                NSLog(@"response: %@ and error: %@", response, error);
                NSDictionary *theatreDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"theatreDictionary: %@", theatreDictionary);
                NSArray *parsedTheatresArray = theatreDictionary[@"theatres"];
                NSLog(@"parsedTheatreDictionary: %@", parsedTheatresArray);
                
                for (NSDictionary *singleTheatreDictionary in parsedTheatresArray){
                    
                    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[singleTheatreDictionary objectForKey:@"lat"] doubleValue],[[singleTheatreDictionary objectForKey:@"lng"] doubleValue]);
                    
                    Theatre *theatre = [[Theatre alloc] initWithName:[singleTheatreDictionary objectForKey:@"name"]
                                                             address:[singleTheatreDictionary objectForKey:@"address"]
                                                       andCoordinate:coordinate];
                    [weakSelf.theatreArray addObject:theatre];
                    
                    self.annotation.title = theatre.name;
                    self.annotation.subtitle = theatre.address;
                    self.annotation.coordinate = coordinate;
                    [self.theatreMapView addAnnotation:self.annotation];
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^
                               {
                                   [weakSelf.theatreMapView reloadInputViews];
                               });
            }];
            [task resume];
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
    
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"theatreAnnotationView"];
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"theatreAnnotationView"];
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"pinSymbol.png"];
            pinView.calloutOffset = CGPointMake(0, 32);
        }
        else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
    return nil;
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
