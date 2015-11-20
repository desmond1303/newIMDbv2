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
    
    init(url: String, urlParamteres: [String:String], sender: TMDDetailsTableViewController, completed: ()->()) {
        super.init()
        Alamofire
            .request(.GET, url, parameters: urlParamteres)
            .responseArray("results") { (response:[TMDMovieReview]?, error: ErrorType?) in
                if let allReviews = response {
                    
                    sender.reviews = allReviews
                    completed()
                    sender.DetailsTableViewOutlet.reloadData()
                }
        }

    }

}
