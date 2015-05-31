//
//  MovieDetailViewController.m
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-29.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MoviesCollectionViewController.h"
#import "Movie.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController

#pragma mark - Managing the detail item

- (void)setMovieDetail:(id)newMovieDetail{
    if (_movieDetail != newMovieDetail) {
        _movieDetail = newMovieDetail;
        [self fetchThreeMovieReviews];
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
        
        NSDictionary *review1Dictionary = self.movieDetail.movieReviewsArray[0];
        self.review1Label.text = [review1Dictionary objectForKey:@"Movie Review:"];
        self.review1CriticAndDateLabel.text = [NSString stringWithFormat:@"%@, %@",[review1Dictionary objectForKey:@"Review Critic:"],[review1Dictionary objectForKey:@"Review Date"]];
        
        NSDictionary *review2Dictionary = self.movieDetail.movieReviewsArray[1];
        self.review2Label.text = [review2Dictionary objectForKey:@"Movie Review:"];
        self.review2CriticAndDateLabel.text = [NSString stringWithFormat:@"%@, %@",[review2Dictionary objectForKey:@"Review Critic:"],[review2Dictionary objectForKey:@"Review Date"]];
        
        NSDictionary *review3Dictionary = self.movieDetail.movieReviewsArray[3];
        self.review3Label.text = [review3Dictionary objectForKey:@"Movie Review:"];
        self.review3CriticAndDateLabel.text = [NSString stringWithFormat:@"%@, %@",[review3Dictionary objectForKey:@"Review Critic:"],[review3Dictionary objectForKey:@"Review Date"]];
    }
}

-(void)fetchThreeMovieReviews{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc]initWithString:@"http://api.rottentomatoes.com/api/public/v1.0/movies/771028170/reviews.json?apikey=sr9tdu3checdyayjz85mff8j&page_limit=50"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    __weak typeof(self)weakSelf = self;
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *movieReviewDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *parsedMovieReviewArray = [movieReviewDictionary objectForKey:@"reviews"];
        
        
        for (NSMutableDictionary *singleReviewDictionary in parsedMovieReviewArray) {
            
            NSString *movieReviewQuote = [singleReviewDictionary objectForKey:@"quote"];
            NSString *movieReviewCritic = [singleReviewDictionary objectForKey:@"critic"];
            NSString *movieReviewDate = [singleReviewDictionary objectForKey:@"date"];
            
            NSMutableDictionary *reviewDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                     movieReviewQuote, @"Movie Review:", movieReviewCritic, @"Review Critic:", movieReviewDate, @"Review Date:", nil];
            
            [self.movieDetail.movieReviewsArray addObject:reviewDictionary];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.view setNeedsDisplay];
        });
        
    }];
    [task resume];
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
