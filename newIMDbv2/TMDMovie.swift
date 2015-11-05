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
    
    var id: Int?
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
    
    var dateFormatter = NSDateFormatter()
    
    required init (_ map: Map) {
        
    }
    
    init(fromObject object: TMDRLMMovies) {
        self.id = object.id
        self.title = object.title
        self.originalTitle = object.originalTitle
        self.imagePath = object.imagePath
        // genres
        self.description = object.movieDescription
        self.popularity = object.popularity
        self.releaseDate = object.releaseDate
        // runtime
        self.voteAvg = object.voteAvg
        self.voteCount = object.voteCount

    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
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
    
    func getDate() -> NSDate {
        self.dateFormatter.dateFormat = "yyyy-mm-dd"
        return self.dateFormatter.dateFromString(self.releaseDate!)!
    }
    
}