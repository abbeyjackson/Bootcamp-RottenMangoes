//
//  MoviesCollectionViewController.m
//  RottenMangoes
//
//  Created by Abegael Jackson on 2015-05-28.
//  Copyright (c) 2015 Abegael Jackson. All rights reserved.
//

#import "MoviesCollectionViewController.h"
#import "Movie.h"

@interface MoviesCollectionViewController ()

@property (nonatomic) NSMutableArray *moviesArray;

@end

@implementation MoviesCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fetchInTheatreMovies];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchInTheatreMovies{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc]initWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=sr9tdu3checdyayjz85mff8j&page_limit=50"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSString *responseString = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//        NSLog (@"Response: %@", responseString);
        self.moviesArray = [NSMutableArray array];
        NSDictionary *moviesDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSArray *parsedMoviesArray = [moviesDictionary objectForKey:@"movies"];
        for (NSDictionary *singleMovieDictionary in parsedMoviesArray) {
            Movie *movie = [[Movie alloc]initWithMovieTitle:[singleMovieDictionary objectForKey:@"title"] movieID:[singleMovieDictionary objectForKey:@"id"] movieYear:[singleMovieDictionary objectForKey:@"year"] andMovieThumbnail:[UIImage imageNamed:[[singleMovieDictionary objectForKey:@"posters"] objectForKey:@"thumbnail"]]];
            [self.moviesArray addObject:movie];
        }
    }];
    [task resume];
    
}

@end
