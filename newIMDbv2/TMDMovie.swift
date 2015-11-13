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

@objc class TMDMovie : NSObject, Mappable {
    
    var id: Int?
    var movieId: Int = 0
    var title : String?
    var originalTitle : String?
    var imagePath : String?
    var genres = [Int]?()
    var movieDescription : String?
    var releaseDate : String?
    var popularity : Double?
    var runtime : Int? //in minutes
    var voteAvg : Double?
    var voteCount : Int?
    
    var objVoteAvg: NSNumber = 0.0
    var objVoteCount: NSInteger = 0
    
    var dateFormatter = NSDateFormatter()
    
    required init (_ map: Map) {
        
    }
    
    init(fromObject object: TMDRLMMovies) {
        self.id = object.movieId
        self.movieId = object.movieId
        self.title = object.title
        self.originalTitle = object.originalTitle
        self.imagePath = object.imagePath
        // genres
        self.movieDescription = object.movieDescription
        self.popularity = object.popularity
        self.releaseDate = object.releaseDate
        // runtime
        self.voteAvg = object.voteAvg
        self.voteCount = object.voteCount
        
        self.objVoteAvg = object.objVoteAvg
        self.objVoteCount = object.objVoteCount

    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.movieId <- map["id"]
        self.title <- map["title"]
        self.originalTitle <- map["original_title"]
        self.imagePath <- map["poster_path"]
        self.genres <- map["genre_ids"]
        self.movieDescription <- map["overview"]
        self.popularity <- map["popularity"]
        self.releaseDate <- map["release_date"]
        self.runtime <- map["runtime"]
        self.voteAvg <- map["vote_average"]
        self.voteCount <- map["vote_count"]
        
        self.objVoteAvg <- map["vote_average"]
        self.objVoteCount <- map["vote_count"]
    }
    
    func getDate() -> NSDate {
        self.dateFormatter.dateFormat = "yyyy-mm-dd"
        if self.releaseDate != "" {
            return self.dateFormatter.dateFromString(self.releaseDate!)!
        }
        else {
            return self.dateFormatter.dateFromString("0001-01-01")!
        }
    }
    
}