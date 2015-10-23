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

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var FavCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FavCollection.delegate = self
        FavCollection.dataSource = self
        
        self.navigationItem.title = "Favorites"
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
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = FavCollection.dequeueReusableCellWithReuseIdentifier("movieTile", forIndexPath: indexPath) as! FavCell
        
        let URL = "https://api.themoviedb.org/3/movie/550"
        Alamofire.request(.GET, URL, parameters: ["api_key":"d94cca56f8edbdf236c0ccbacad95aa1"])
            .responseObject {(response: TMDMovie?, error: ErrorType?) in
                cell.movieTitle.text = response?.title
                if let imageUrl = response?.imagePath {
                    let resolution = "w185"
                    let fullUrl = "http://image.tmdb.org/t/p/\(resolution)/\(imageUrl)"
                    cell.movieImage.sd_setImageWithURL(NSURL(string: fullUrl), completed: nil)
                }
            }
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

