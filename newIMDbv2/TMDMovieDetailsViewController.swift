//
//  TMDMovieDetailsViewController.swift
//  newIMDbv2
//
//  Created by Dino Prašo on 23/10/15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//
/*
import UIKit
import Alamofire
import SDWebImage
import RealmSwift

class TMDMovieDetailsViewController: UITableViewController {
    
    var movie: TMDMovie?
    var reviews: [TMDMovieReview]?
    var noReviews: Bool = false
    let realm = try! Realm()
    var isFav = false
    
    @IBOutlet var MovieDetailsTableViewOutlet: UITableView!

    @IBOutlet weak var favoritesBarButtonItem: UIBarButtonItem!
    @IBAction func addFavoriteButton(sender: AnyObject) {
        
        if isFav {
            let movie = realm.objects(TMDRLMMovies).filter("id = \(self.movie!.id!)")
            try! self.realm.write {
                self.realm.delete(movie)
            }
            
            self.favoritesBarButtonItem.image = UIImage(named: "FavNotSelected")
            
        }
        else {
            let favoriteMovie = TMDRLMMovies()
            favoriteMovie.movieId = self.movie!.id!
            favoriteMovie.title = self.movie!.title!
            
            favoriteMovie.originalTitle = self.movie!.originalTitle!
            favoriteMovie.imagePath = self.movie!.imagePath!
            //favoriteMovie.genres = self.movie!.genres!
            favoriteMovie.movieDescription = self.movie!.movieDescription!
            favoriteMovie.releaseDate = self.movie!.releaseDate!
            favoriteMovie.popularity = self.movie!.popularity!
            
            favoriteMovie.voteAvg = self.movie!.voteAvg!
            favoriteMovie.voteCount = self.movie!.voteCount!
            
            try! self.realm.write {
                self.realm.add(favoriteMovie)
            }
            
            self.favoritesBarButtonItem.image = UIImage(named: "FavSelected")

        }
        
        self.MovieDetailsTableViewOutlet.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let url = "https://api.themoviedb.org/3/movie/\(self.movie!.id!)/reviews"
        let urlParamteres = ["api_key":"d94cca56f8edbdf236c0ccbacad95aa1"]
        
        Alamofire
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
        
        let movieThatExists = self.realm.objects(TMDRLMMovies).filter("id == \(self.movie!.id!)").first
        
        if movieThatExists != nil {
            self.favoritesBarButtonItem.image = UIImage(named: "FavSelected")
            self.isFav = true
        } else {
            self.favoritesBarButtonItem.image = UIImage(named: "FavNotSelected")
            self.isFav = false
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.movie?.title
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else {
            return self.reviews?.count ?? 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "About" : "Reviews"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = MovieDetailsTableViewOutlet.dequeueReusableCellWithIdentifier("movieDetailsHeader", forIndexPath: indexPath) as! TMDDetailsTableViewCell
                
                cell.movieTitleLabel.text = self.movie?.title
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy"
                cell.movieYearLabel.text = dateFormatter.stringFromDate((self.movie?.getDate())!)
                
                cell.movieImageView.sd_setImageWithURL(NSURL(string: "http://image.tmdb.org/t/p/w342/\(self.movie!.imagePath!)"), completed: {
                    (image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
                    print(self)
                })
                
                cell.votesProgreessView.progress = Float(self.movie!.voteAvg!  / 10)
                cell.votesProgressLabel.text = String(self.movie!.voteAvg!)
                cell.voteCountLabel.text = "\(String(self.movie!.voteCount!)) votes"
                
                return cell
            }
            else {
                let cell = MovieDetailsTableViewOutlet.dequeueReusableCellWithIdentifier("movieDetailsBody", forIndexPath: indexPath) as! TMDDetailsDescriptionTableViewCell
                
                cell.movieDescriptionTextbox.text = self.movie?.movieDescription
                
                return cell
            }

        }
        else {
            let cell = MovieDetailsTableViewOutlet.dequeueReusableCellWithIdentifier("movieReview", forIndexPath: indexPath) as! TMDReviewTableCell
            
            if noReviews == true {
                cell.authorLabel.text = "No Reivews For This Movie Yet"
                return cell
            }
            
            if let review = reviews?[indexPath.item] {
                cell.authorLabel.text = review.author
                cell.reviewText.text = review.content
            }
            
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        if (indexPath.section == 0 && indexPath.row == 1) || indexPath.section == 1 {
            return CGFloat(130)
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
*/
