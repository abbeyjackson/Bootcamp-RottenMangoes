//
//  Movie.m
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-28.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype)initWithMovieTitle:(NSString*)movieTitle movieID:(NSString*)movieID movieYear:(NSString*)movieYear andMovieThumbnail:(UIImage*)movieThumbnail{
    self = [super init];
    if (self){
        _movieTitle = movieTitle;
        _movieID = movieID;
        _movieYear = movieYear;
        _movieThumbnail = movieThumbnail;
    }
    return self;
}

@end
