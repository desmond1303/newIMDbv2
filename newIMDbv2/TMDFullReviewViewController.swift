//
//  TMDFullReviewViewController.swift
//  newIMDbv2
//
//  Created by Dino Praso on 12.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit

class TMDFullReviewViewController: UIViewController {
    
    var author: String?
    var reviewText: String?

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reviewTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorLabel.text = self.author
        self.reviewTextField.text = self.reviewText
        
        
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
