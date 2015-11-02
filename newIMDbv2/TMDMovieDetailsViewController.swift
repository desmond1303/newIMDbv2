//
//  TMDMovieDetailsViewController.swift
//  newIMDbv2
//
//  Created by Dino Prašo on 23/10/15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit
import SDWebImage

class TMDMovieDetailsViewController: UITableViewController {
    
    @IBOutlet var MovieDetailsTableViewOutlet: UITableView!

    var movie: TMDMovie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.movie?.title
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "About" : "Reviews"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = MovieDetailsTableViewOutlet.dequeueReusableCellWithIdentifier("movieDetailsHeader", forIndexPath: indexPath) as! TMDDetailsTableViewCell
                
                cell.movieTitleLabel.text = self.movie?.title
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy"
                cell.movieYearLabel.text = dateFormatter.stringFromDate((self.movie?.getDate())!)
                
                cell.movieImageView.sd_setImageWithURL(NSURL(string: "http://image.tmdb.org/t/p/w342/\(self.movie!.imagePath!)"), completed: {
                    (image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
                    print(self)
                })
                
                cell.votesProgreessView.progress = Float(self.movie!.voteAvg!  / 10)
                cell.votesProgressLabel.text = String(self.movie!.voteAvg!)
                cell.voteCountLabel.text = "\(String(self.movie!.voteCount!)) votes"
                
                return cell
            }
            else {
                let cell = MovieDetailsTableViewOutlet.dequeueReusableCellWithIdentifier("movieDetailsBody", forIndexPath: indexPath) as! TMDDetailsDescriptionTableViewCell
                
                cell.movieDescriptionTextbox.text = self.movie?.description
                
                return cell
            }

        }
        else {
            let cell = MovieDetailsTableViewOutlet.dequeueReusableCellWithIdentifier("movieDetailsBody", forIndexPath: indexPath) as! TMDDetailsDescriptionTableViewCell
            
            cell.movieDescriptionTextbox.text = "The review Section"
            
            return cell
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
