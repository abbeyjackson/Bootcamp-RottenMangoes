//
//  TheatresMapViewController.h
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-30.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class Movie;


@interface TheatresMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *theatreMapView;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (strong, nonatomic) CLPlacemark *currentLocation;
@property (strong, nonatomic) Movie *movie;
@property (strong, nonatomic) NSMutableArray *theatreArray;
@property (strong, nonatomic) MKPointAnnotation *annotation;


@end
