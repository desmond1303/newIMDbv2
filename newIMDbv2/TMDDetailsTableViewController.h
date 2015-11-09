//
//  TMDDetailsTableViewController.h
//  newIMDbv2
//
//  Created by Dino Praso on 3.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Realm/Realm.h>
@import Alamofire;
@import SDWebImage;

@class TMDMovie;
@class TMDMovieReview;
@class AlamofireWrapper;

@interface TMDDetailsTableViewController : UITableViewController

@property (strong, nonatomic) TMDMovie *movie;

@end