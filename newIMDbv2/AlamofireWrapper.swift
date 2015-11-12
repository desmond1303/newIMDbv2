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
    
    var reviews = [TMDMovieReview]()
    
    init(url: String, urlParamteres: [String:String], sender: TMDDetailsTableViewController) {
        super.init()
        Alamofire
            .request(.GET, url, parameters: urlParamteres)
            .responseArray("results") { (response:[TMDMovieReview]?, error: ErrorType?) in
                if let allReviews = response {
                    self.reviews = allReviews
                    sender.reviews = allReviews
                    sender.DetailsTableViewOutlet.reloadData()
                    NSLog("Alamofire Finished Execution")
                    
                }
        }

    }
    
    func getResponse() -> [AnyObject] {
        return self.reviews
    }
    
    func getResponse(forItemAtIndexPath indexPath: Int) -> AnyObject {
        return self.reviews[indexPath]
    }
    
    func getResponse(forProperty property: String) -> [AnyObject] {
        switch property {
            case "id":
                var returning = [Int]()
                for review in self.reviews {
                    returning.append(review.id!)
                }
                return returning
            case "author":
                var returning = [String]()
                for review in self.reviews {
                    returning.append(review.author!)
                }
                return returning
            case "content":
                var returning = [String]()
                for review in self.reviews {
                    returning.append(review.content!)
                }
                return returning
            default:
                return self.reviews
            
        }
    }


}
