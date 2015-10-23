//
//  TMDMovieDetailsViewController.swift
//  newIMDbv2
//
//  Created by Dino Prašo on 23/10/15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit

class TMDMovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    
    func displayInLabel(string: String) {
        self.movieTitleLabel.text = string;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
