//
//  TMDDetailsTableViewCell.swift
//  newIMDbv2
//
//  Created by Dino Praso on 30.10.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit

class TMDDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
