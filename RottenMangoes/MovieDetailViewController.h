//
//  MovieDetailViewController.h
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-29.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Movie;

@interface MovieDetailViewController : UIViewController

@property (nonatomic) Movie *movieDetail;
@property (weak, nonatomic) IBOutlet UIView *movieThumbnailDetailBackground;
@property (weak, nonatomic) IBOutlet UIImageView *movieDetailThumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *movieDetailYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDetailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDetailSynopsisLabel;

@end
