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
    var imagePath : String?
    var genres = [String]?()
    var description : String?
    var releaseDate : String?
    var runtime : Int? //in minutes
    var voteAvg : Double?
    var voteCount : Int?
    
    required init (_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.title <- map["title"]
        self.imagePath <- map["poster_path"]
        self.genres <- map["genres"]
        self.description <- map["description"]
        self.releaseDate <- map["release_date"]
        self.runtime <- map["runtime"]
        self.voteAvg <- map["vote_average"]
        self.voteCount <- map["vote_count"]
    }
    
}