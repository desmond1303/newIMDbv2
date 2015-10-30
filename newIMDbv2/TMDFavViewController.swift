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
    
    var apiFilter = "top_rated"

    @IBAction func filterButton(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Choose a filter", message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)

        
        let TopRatedFilterAction = UIAlertAction(title: "Top Rated", style: .Default) { (action) in
            self.apiFilter = "top_rated"
            self.viewWillAppear(true)
        }
        alertController.addAction(TopRatedFilterAction)
        
        let PopularFilterAction = UIAlertAction(title: "Popular", style: .Default) { (action) in
            self.apiFilter = "popular"
            self.viewWillAppear(true)
        }
        alertController.addAction(PopularFilterAction)
        
        
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    @IBOutlet weak var TMDFavCollectionOutlet: UICollectionView!

    var movies : [TMDMovie]?
    var displayColumns: CGFloat = 2
    
    override func viewWillAppear(animated: Bool) {
        let url = "https://api.themoviedb.org/3/movie/\(self.apiFilter)"
        let urlParamteres = ["api_key":"d94cca56f8edbdf236c0ccbacad95aa1"]
        
        Alamofire
            .request(.GET, url, parameters: urlParamteres)
            .responseArray("results") { (response:[TMDMovie]?, error: ErrorType?) in
                self.movies = response!
                self.TMDFavCollectionOutlet.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TMDFavCollectionOutlet.delegate = self
        TMDFavCollectionOutlet.dataSource = self
        
        self.navigationItem.title = "Favorites"
       
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
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        cell.movieYearLabel.text = dateFormatter.stringFromDate(currentMovie.getDate())
        
        cell.movieImage.sd_setImageWithURL(NSURL(string: "http://image.tmdb.org/t/p/w342/\(currentMovie.imagePath!)"), completed: {
            (image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
            print(self)
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.item == 0 && self.displayColumns == 2 {
            return CGSize(width: CGRectGetWidth(collectionView.bounds), height: 200)
        }
        else {
            return CGSize(width: (CGRectGetWidth(collectionView.bounds)/self.displayColumns)-2.5*self.displayColumns, height: 270)
        }
            
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if toInterfaceOrientation.isPortrait {
            self.displayColumns = 2
        }
        else {
            self.displayColumns = 4
        }
        self.TMDFavCollectionOutlet.reloadData()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMovieDetails" {
            let detailsViewController = segue.destinationViewController as! TMDMovieDetailsViewController
            detailsViewController.displayInLabel("Test")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}