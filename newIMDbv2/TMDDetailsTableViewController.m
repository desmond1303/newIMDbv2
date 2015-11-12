//
//  TMDDetailsTableViewController.m
//  newIMDbv2
//
//  Created by Dino Praso on 3.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

#import "TMDDetailsTableViewController.h"
#import "newIMDbv2-Swift.h"

@interface TMDDetailsTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *MovieDetailsTableViewOutlet;

@property (strong, nonatomic) NSArray<TMDMovieReview *> *reviews;
@property (strong, nonatomic) RLMRealm *realm;

@property (strong, nonatomic) IBOutlet UITableView *DetailsTableViewOutlet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoritesBarButtonItem;

@end

@implementation TMDDetailsTableViewController

bool isFav = NO;

- (IBAction)favoritesBarButtonAction:(id)sender {
    _realm = [RLMRealm defaultRealm];
    if (isFav) {
        
        
        RLMResults *resultMovie = [TMDRLMMovies objectsWhere:[NSString stringWithFormat:@"movieId=%ld", _movie.movieId]];
        
        [_realm beginWriteTransaction];
        [_realm deleteObject:resultMovie[0]];
        [_realm commitWriteTransaction];
         
        
        
        [self favoritesBarButtonItem].image = [UIImage imageNamed:@"FavNotSelected"];
        
        isFav = NO;
    }
    else {
        
        TMDRLMMovies *favoriteMovie = [[TMDRLMMovies alloc] init];
        favoriteMovie.movieId = _movie.movieId;
        favoriteMovie.title = _movie.title;
        favoriteMovie.originalTitle = _movie.originalTitle;
        favoriteMovie.imagePath = _movie.imagePath;
        //favoriteMovie.genres = _movie.genres;
        favoriteMovie.movieDescription = _movie.movieDescription;
        favoriteMovie.releaseDate = _movie.releaseDate;
        //favoriteMovie.popularity = _movie.popularity;
        //favoriteMovie.voteAvg = _movie.voteAvg;
        //favoriteMovie.voteCount = movie.voteCount;
        
        [_realm beginWriteTransaction];
        [_realm addObject:favoriteMovie];
        [_realm commitWriteTransaction];
        
        [self favoritesBarButtonItem].image = [UIImage imageNamed:@"FavSelected"];
        
        isFav = YES;
        
    }
    
    [[self MovieDetailsTableViewOutlet] reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *url = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld/reviews", (long)_movie.movieId];
    NSDictionary *urlParameters = @{@"api_key":@"d94cca56f8edbdf236c0ccbacad95aa1"};
    
    
    AlamofireWrapper *aWrapper = [[AlamofireWrapper alloc] initWithUrl:url urlParamteres:urlParameters];
    _reviews = [aWrapper getResponse];
    [[self MovieDetailsTableViewOutlet] reloadData];
    
    
    RLMResults *movieThatExists = [TMDRLMMovies objectsWhere:[NSString stringWithFormat:@"movieId=%ld", _movie.movieId]];
    
    if (movieThatExists.count != 0) {
        [self favoritesBarButtonItem].image = [UIImage imageNamed: @"FavSelected"];
        isFav = YES;
    } else {
        [self favoritesBarButtonItem ].image = [UIImage imageNamed: @"FavNotSelected"];
        isFav = NO;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationItem].title = _movie.title;
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 2;
    else return [_reviews count] > 0 ? [_reviews count] : 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"About" : @"Reviews";
 }


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        if(indexPath.row == 0) {
            TMDDetailsTableViewCell *cell = [_MovieDetailsTableViewOutlet dequeueReusableCellWithIdentifier:@"movieDetailsHeader" forIndexPath:indexPath];
            
            [cell movieTitleLabel].text = _movie.title;
            [[cell movieImageView] sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w342/%@", _movie.imagePath]]];
            
            //[cell votesProgreessView].progress = (float)_movie.voteAvg/10;
            //[cell votesProgressLabel].text = _movie.voteAvg;
            //[cell voteCountLabel].text = [NSString stringWithFormat:@"%@ votes", _movie.voteCount];
            
            return cell;
        }
        else {
            TMDDetailsDescriptionTableViewCell *cell = [_MovieDetailsTableViewOutlet dequeueReusableCellWithIdentifier:@"movieDetailsBody" forIndexPath:indexPath];
            
            [cell movieDescriptionTextbox].text = _movie.movieDescription;
            
            return cell;
        }
    }
    else {
        TMDReviewTableCell *cell = [_MovieDetailsTableViewOutlet dequeueReusableCellWithIdentifier:@"movieReview" forIndexPath:indexPath];
        
        NSLog(@"Test");
        
        if (_reviews.count > 0) {
            TMDMovieReview *currentReview = _reviews[indexPath.row];
            
            [cell authorLabel].text = @"Test Author Name"; //[currentReview getAuthor];
            [cell reviewText].text = @"Test Review Content"; //[currentReview getContent];
            
            return cell;
        }
        
        [cell authorLabel].text = @"No Reviews For This Movie Yet";
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == 0 && indexPath.row == 1) || indexPath.section == 1) {
        return 130;
    }
    else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
