//
//  Movie.h
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-28.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface Movie : NSObject

@property (nonatomic) NSString *movieTitle;
@property (nonatomic) NSString *movieID;
@property (nonatomic) NSString *movieYear;
@property (nonatomic) NSString *movieSynopsis;
@property (nonatomic) NSURL *movieThumbnailNSURL;
@property (nonatomic) UIImage *movieThumbnail;
//@property (nonatomic) NSString *imageURLString;

-(instancetype)initWithMovieTitle:(NSString*)movieTitle movieID:(NSString*)movieID movieYear:(NSString*)movieYear movieSynopsis:(NSString*)movieSynopsis andMovieThumbnailNSURL:(NSURL*)movieThumbnailNSURL;

@end
