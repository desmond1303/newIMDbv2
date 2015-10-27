//
//  ViewController.swift
//  newIMDbv2
//
//  Created by Dino Prašo on 22/10/15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SDWebImage

class TMDFavViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var TMDFavCollectionOutlet: UICollectionView!

    var movies : [TMDMovie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDFavCollectionOutlet.delegate = self
        TMDFavCollectionOutlet.dataSource = self
        
        self.navigationItem.title = "Favorites"
       
        
        let url = "https://api.themoviedb.org/3/movie/top_rated"
        let urlParamteres = ["api_key":"d94cca56f8edbdf236c0ccbacad95aa1"]
        
        Alamofire
            .request(.GET, url, parameters: urlParamteres)
            .responseArray("results") { (response:[TMDMovie]?, error: ErrorType?) in
                self.movies = response!
                
                self.TMDFavCollectionOutlet.reloadData()
        }

        
        /*
        let filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        self.navigationItem.rightBarButtonItem = filterButton
        */
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movie = self.movies {
            return movie.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = TMDFavCollectionOutlet.dequeueReusableCellWithReuseIdentifier("movieTile", forIndexPath: indexPath) as! TMDFavCell
        
        let currentMovie = self.movies![indexPath.row]
        
        cell.movieTitleLabel.text = currentMovie.title
        
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
            print(self)
        }
        

        
        cell.movieImage.sd_setImageWithURL(NSURL(string: "http://image.tmdb.org/t/p/w342/\(currentMovie.imagePath!)"), completed: block)
        
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let senderTile =
        if segue.identifier == "showMovieDetails" {
            // pass data to next view
            let detailsViewController = segue.destinationViewController as! TMDMovieDetailsViewController
            detailsViewController.displayInLabel("Test")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

