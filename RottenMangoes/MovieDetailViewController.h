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

@property (nonatomic) Movie *movie;
@property (weak, nonatomic) IBOutlet UIView *movieThumbnailDetailBackground;
@property (weak, nonatomic) IBOutlet UIImageView *movieDetailThumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *movieDetailYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDetailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDetailSynopsisLabel;

@property (weak, nonatomic) IBOutlet UILabel *review1Label;
@property (weak, nonatomic) IBOutlet UILabel *review2Label;
@property (weak, nonatomic) IBOutlet UILabel *review3Label;

@property (weak, nonatomic) IBOutlet UILabel *review1CriticAndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *review2CriticAndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *review3CriticAndDateLabel;
@end
