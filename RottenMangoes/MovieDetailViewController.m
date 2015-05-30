//
//  MovieDetailViewController.m
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-29.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "Movie.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

#pragma mark - Managing the detail item

- (void)setMovieDetail:(id)newMovieDetail{
    if (_movieDetail != newMovieDetail) {
        _movieDetail = newMovieDetail;
        
        // Update the view.
        [self configureView];
    }
}

-(void)configureView{
    // Update the user interface for the detail item
    
    if (self.movieDetail) {
        self.movieDetailThumbnailView.image = self.movieDetail.movieThumbnail;
        self.movieDetailYearLabel.text = [NSString stringWithFormat:@"%d", self.movieDetail.movieYear];
        self.movieDetailTitleLabel.text = self.movieDetail.movieTitle;
        self.movieDetailSynopsisLabel.text = self.movieDetail.movieSynopsis;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
