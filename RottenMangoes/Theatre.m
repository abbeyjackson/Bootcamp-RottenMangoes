//
//  Theatre.m
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-06-08.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "Theatre.h"

@implementation Theatre

-(instancetype)initWithName:(NSString*)name address:(NSString*)address andCoordinate:(CLLocationCoordinate2D)coordinate{
    self = [super init];
    if (self){
        _name = name;
        _address = address;
        self.coordinate = coordinate;
    }
    return self;
}


@end
