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
    
    var myTMDMovie: [TMDMovie]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TMDFavCollectionOutlet.delegate = self
        TMDFavCollectionOutlet.dataSource = self
        
        self.navigationItem.title = "Favorites"
        
        let URL = "https://api.themoviedb.org/3/discover/movie"
        Alamofire
            .request(.GET, URL, parameters: ["api_key":"d94cca56f8edbdf236c0ccbacad95aa1"])
            .responseObject {(response: TMDMovie?, error: ErrorType?) in
                
                
                
            }
    
        /*
        let filterButton = UIBarButtonItem(title: "Filter", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        self.navigationItem.rightBarButtonItem = filterButton
        */
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = TMDFavCollectionOutlet.dequeueReusableCellWithReuseIdentifier("movieTile", forIndexPath: indexPath) as! TMDFavCell
        cell.movieTitleLabel.text = "This will be a realtively long title"
        
        
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

