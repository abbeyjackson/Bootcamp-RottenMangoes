//
//  Theatre.h
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-06-08.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Theatre : MKPointAnnotation

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;


-(instancetype)initWithName:(NSString*)name address:(NSString*)address andCoordinate:(CLLocationCoordinate2D)coordinate;


@end
