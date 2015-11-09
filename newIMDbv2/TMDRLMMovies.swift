//
//  TMDRLMMovies.swift
//  newIMDbv2
//
//  Created by Dino Praso on 3.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit
import RealmSwift

@objc class TMDRLMMovies: Object {
    dynamic var movieId = 0
    dynamic var title : String = ""
    dynamic var originalTitle : String = ""
    dynamic var imagePath : String = ""
    //dynamic var genres = NSMutableArray()
    dynamic var movieDescription : String = ""
    dynamic var releaseDate : String = ""
    dynamic var popularity : Double = 0
    //dynamic var runtime : Int = 0 //in minutes
    dynamic var voteAvg : Double = 0
    dynamic var voteCount : Int = 0
    
    //override static func primaryKey() -> String? {
      //  return "movieId"
    //}
    
}
