//
//  TMDMovie.swift
//  newIMDbv2
//
//  Created by Dino Prašo on 22/10/15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//
import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class TMDMovie : Mappable {
    
    var title : String?
    var originalTitle : String?
    var imagePath : String?
    var genres = [Int]?()
    var description : String?
    var releaseDate : String?
    var popularity : Double?
    var runtime : Int? //in minutes
    var voteAvg : Double?
    var voteCount : Int?
    
    required init (_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.title <- map["title"]
        self.originalTitle <- map["original_title"]
        self.imagePath <- map["poster_path"]
        self.genres <- map["genre_ids"]
        self.description <- map["overview"]
        self.popularity <- map["popularity"]
        self.releaseDate <- map["release_date"]
        self.runtime <- map["runtime"]
        self.voteAvg <- map["vote_average"]
        self.voteCount <- map["vote_count"]
    }
    
}