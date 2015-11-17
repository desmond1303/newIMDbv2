//
//  TMDDetailsTableViewController.m
//  newIMDbv2
//
//  Created by Dino Praso on 3.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

#import "TMDDetailsTableViewController.h"
#import "newIMDbv2-Swift.h"
#import "TMDAlertView.h"

@interface TMDDetailsTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *MovieDetailsTableViewOutlet;
@property (strong, nonatomic) RLMRealm *realm;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoritesBarButtonItem;

@property (strong, nonatomic) TMDAlertView *alterView;

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
        //favoriteMovie.objPopularity = _movie.popularity;
        favoriteMovie.objVoteAvg = _movie.objVoteAvg;
        favoriteMovie.objVoteCount = _movie.objVoteCount;
        
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
    
    CGRect alterViewRect = CGRectMake((CGFloat)20, (CGFloat)20, (CGFloat)150, (CGFloat)150);
    _alterView = [[TMDAlertView alloc] initWithFrame:alterViewRect];
    [_alterView showAlertViewWithMessage:@"Still Loading" type:DefaultAlertType shouldRotate:YES];
    
    NSString *url = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%ld/reviews", (long)_movie.movieId];
    NSDictionary *urlParameters = @{@"api_key":@"d94cca56f8edbdf236c0ccbacad95aa1"};
    
    
    AlamofireWrapper *aWrapper = [[AlamofireWrapper alloc] initWithUrl:url urlParamteres:urlParameters sender: self];
    #pragma unused (aWrapper)

    
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
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy";
            [cell movieYearLabel].text = [dateFormatter stringFromDate:[_movie getDate]];
            [[cell movieImageView] sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w342/%@", _movie.imagePath]]];
            
            [cell votesProgreessView].progress = [_movie.objVoteAvg doubleValue]/10;
            [cell votesProgressLabel].text =  [NSString stringWithFormat:@"%.01f", [_movie.objVoteAvg floatValue]];
            [cell voteCountLabel].text = [NSString stringWithFormat:@"%ld votes", _movie.objVoteCount];
            
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
        
        if (_reviews.count > 0) {
            TMDMovieReview *currentReview = [_reviews objectAtIndex:indexPath.row];
            
            [cell authorLabel].text = currentReview.author;
            [cell reviewText].text = currentReview.content;
            
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(TMDReviewTableCell*)sender {
    if ([segue.identifier isEqual: @"reviewReadMore"]) {
        TMDFullReviewViewController *destinationViewController = [segue destinationViewController];
        destinationViewController.author = [sender authorLabel].text;
        destinationViewController.reviewText = [sender reviewText].text;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
