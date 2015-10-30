//
//  TMDDetailsDescriptionTableViewCell.swift
//  newIMDbv2
//
//  Created by Dino Praso on 30.10.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit

class TMDDetailsDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var movieDescriptionTextbox: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
