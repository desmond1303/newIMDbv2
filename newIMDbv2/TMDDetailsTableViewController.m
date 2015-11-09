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

@property (strong, nonatomic) TMDMovieReview *reviews;
@property (strong, nonatomic) RLMRealm *realm;

@property (strong, nonatomic) IBOutlet UITableView *DetailsTableViewOutlet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoritesBarButtonItem;

@end

@implementation TMDDetailsTableViewController

bool noReviews = NO;
bool isFav = NO;

- (IBAction)favoritesBarButtonAction:(id)sender {
    _realm = [RLMRealm defaultRealm];
    if (isFav) {
        
        /*
         RLMResults *movie = [TMDRLMMovies objectsWhere:@"test"];
        
        [_realm beginWriteTransaction];
        [_realm deleteObject:movie];
        [_realm commitWriteTransaction];
         
         */
        
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
        //favoriteMovie.voteCount = _movie.voteCount;
        
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
    

    Alam
    
    Alamofirew
    .request(.GET, url, parameters: urlParamteres)
    .responseArray("results") { (response:[TMDMovieReview]?, error: ErrorType?) in
        if let allReviews = response {
            self.reviews = allReviews
        }
        else {
            self.noReviews = true
        }
        self.MovieDetailsTableViewOutlet.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *moveititle = _movie.title;
   

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
    else return 1; //self.reviews.count
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMDDetailsTableViewCell *cell = [_MovieDetailsTableViewOutlet dequeueReusableCellWithIdentifier:@"movieDetailsHeader" forIndexPath:indexPath];
    [cell movieTitleLabel].text = @"Test";
    
    // Configure the cell...
    
    return cell;
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
