//
//  TMDReviewTableCell.swift
//  newIMDbv2
//
//  Created by Dino Praso on 2.11.15.
//  Copyright © 2015 Atlantbh. All rights reserved.
//

import UIKit

class TMDReviewTableCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reviewText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
