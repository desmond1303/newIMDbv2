//
//  TMDRLMCollectionViewController.swift
//  newIMDbv2
//
//  Created by Dino Praso on 5.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit
import SDWebImage
import Realm
import RealmSwift

private let reuseIdentifier = "RLMfavoriteMovieTile"

class TMDRLMCollectionViewController: UICollectionViewController {
    
    var displayColumns: CGFloat = 2
    var sortBy: String = "title"
    var sortAscending: Bool = true
    
    @IBAction func filterBarButtonAction(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Choose a filter", message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        
        let TitleFilterAction = UIAlertAction(title: "Title", style: .Default) { (action) in
            self.sortBy = "title"
            self.viewWillAppear(true)
        }
        alertController.addAction(TitleFilterAction)
        
        let ReleaseDateFilterAction = UIAlertAction(title: "Release Date", style: .Default) { (action) in
            self.sortBy = "releaseDate"
            self.viewWillAppear(true)
        }
        alertController.addAction(ReleaseDateFilterAction)
        
        let PopularityFilterAction = UIAlertAction(title: "Popularity", style: .Default) { (action) in
            self.sortBy = "popularity"
            self.viewWillAppear(true)
        }
        alertController.addAction(PopularityFilterAction)
        
        let SwitchFilterAction = UIAlertAction(title: "Switch Asc/Desc", style: .Default) { (action) in
            if self.sortAscending == true {
                self.sortAscending = false
            }
            else {
                self.sortAscending = true
            }
            self.viewWillAppear(true)
        }
        alertController.addAction(SwitchFilterAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }

    }
    

    @IBOutlet var collectionViewOutlet: UICollectionView!
    var favoriteMovies = [TMDMovie]()
    let realm = try! Realm()
    
    func getRealmMovies() {
        let RLMFavs = TMDRLMMovies.allObjects().sortedResultsUsingProperty(self.sortBy, ascending: self.sortAscending)
        self.favoriteMovies.removeAll()
        for var i in 0..<RLMFavs.count {
            self.favoriteMovies.append(TMDMovie(fromObject: RLMFavs[UInt(i++)] as! TMDRLMMovies))
            self.collectionViewOutlet.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.getRealmMovies()
        self.collectionViewOutlet.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Favorites"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.favoriteMovies.count
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TMDFavCell
        
        let currentMovie = self.favoriteMovies[indexPath.item]
    
        cell.movieTitleLabel.text = currentMovie.title!
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        cell.movieYearLabel.text = dateFormatter.stringFromDate(currentMovie.getDate())
        
        cell.movieImage.sd_setImageWithURL(NSURL(string: "http://image.tmdb.org/t/p/w342/\(currentMovie.imagePath!)"), completed: {
            (image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
            print(self)
        })
        // Configure the cell
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (CGRectGetWidth(collectionView.bounds)/self.displayColumns)-2.5*self.displayColumns, height: 270)
        
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if toInterfaceOrientation.isPortrait {
            self.displayColumns = 2
        }
        else {
            self.displayColumns = 4
        }
        self.collectionViewOutlet.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let sender = sender as! TMDFavCell
        
        if segue.identifier == "showMovieDetails" {
            let detailsViewController = segue.destinationViewController as! TMDDetailsTableViewController
            let indexPath: NSIndexPath = self.collectionViewOutlet.indexPathForCell(sender)!
            
            detailsViewController.movie = self.favoriteMovies[indexPath.item]
        }
        
    }



    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
