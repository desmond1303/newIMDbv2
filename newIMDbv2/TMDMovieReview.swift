//
//  TMDMovieReview.swift
//  newIMDbv2
//
//  Created by Dino Praso on 2.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//
import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class TMDMovieReview : Mappable {
    
    var id: Int?
    var author : String?
    var content : String?
    
    var dateFormatter = NSDateFormatter()
    
    required init (_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.author <- map["author"]
        self.content <- map["content"]
    }
    
}