//
//  AlamofireWrapper.swift
//  newIMDbv2
//
//  Created by Dino Praso on 9.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit
import Alamofire

@objc class AlamofireWrapper: NSObject {
    
    var reviews: [TMDMovieReview]?
    var noReviews: Bool = false
    
    init(url: String, urlParamteres: [String:String]) {
        super.init()
        Alamofire
            .request(.GET, url, parameters: urlParamteres)
            .responseArray("results") { (response:[TMDMovieReview]?, error: ErrorType?) in
                if let allReviews = response {
                    self.reviews = allReviews
                }
                else {
                    self.noReviews = true
                }
        }

    }
    
    @objc func getResponse() -> NSMutableArray {
        return NSMutableDictionary(dictionary: self.reviews!)
    }

}
