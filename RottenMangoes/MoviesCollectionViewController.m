//
//  MoviesCollectionViewController.m
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-28.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "MoviesCollectionViewController.h"
#import "Movie.h"
#import "MovieCollectionViewCell.h"
#import "MovieDetailViewController.h"

@interface MoviesCollectionViewController ()

@property (nonatomic) NSMutableArray *moviesArray;

@end

@implementation MoviesCollectionViewController

static NSString * const reuseIdentifier = @"MovieCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.moviesArray = [NSMutableArray array];
    [self fetchInTheatreMovies];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"movieDetailView"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        
        Movie *movie = self.moviesArray[indexPath.item];
        [[segue destinationViewController] setMovie:movie];
    }
}


-(void)fetchInTheatreMovies{
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc]initWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=sr9tdu3checdyayjz85mff8j&page_limit=50"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    __weak typeof(self)weakSelf = self;
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *moviesDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *parsedMoviesArray = [moviesDictionary objectForKey:@"movies"];
        
        
        for (NSDictionary *singleMovieDictionary in parsedMoviesArray) {
            
            NSString *movieThumbnailURL = [[singleMovieDictionary objectForKey:@"posters"] objectForKey:@"thumbnail"];
            
            Movie *movie = [[Movie alloc]initWithMovieTitle:[singleMovieDictionary objectForKey:@"title"]
                                                    movieID:[singleMovieDictionary objectForKey:@"id"]
                                                  movieYear:[[singleMovieDictionary objectForKey:@"year"] intValue]
                                              movieSynopsis:[singleMovieDictionary objectForKey:@"synopsis"]
                                        andMovieThumbnailNSURL:[NSURL URLWithString:movieThumbnailURL]];
            
            [weakSelf.moviesArray addObject:movie];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
        });
        
    }];
    [task resume];
    
}



- (UIImage*)fetchImagesForMovies:(NSIndexPath *)indexPath{
    
    Movie *movie = self.moviesArray[indexPath.item];
    NSData *movieThumbnailData = [NSData dataWithContentsOfURL:movie.movieThumbnailNSURL];
    UIImage *movieThumbnail = [UIImage imageWithData:movieThumbnailData];
    return movieThumbnail;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.moviesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Movie *movie = self.moviesArray[indexPath.item];
    UIImage *image = [self fetchImagesForMovies:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    cell.movieThumbnailView.image = image;
    
    //populate movie objects in array with UIImage
    movie.movieThumbnail = image;
    
    
    return cell;
}

@end



