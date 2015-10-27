//
//  TMDMovie.swift
//  newIMDbv2
//
//  Created by Dino Prašo on 22/10/15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//
import UIKit

class TMDMovie {
    
    var title : String?
    var imagePath : String?
    var genres = [String]?()
    var description : String?
    var releaseDate : String?
    var runtime : Int? //in minutes
    var voteAvg : Double?
    var voteCount : Int?
    
    init(title: String) {
        self.title = title
        /*
        self.imagePath = imagePath
        self.genres = genres
        self.description = description
        self.releaseDate <- map["release_date"]
        self.runtime <- map["runtime"]
        self.voteAvg <- map["vote_average"]
        self.voteCount <- map["vote_count"]
        */
    }
    
}