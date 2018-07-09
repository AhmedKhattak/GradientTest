//
//  NoiceTableViewCell.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 07/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import UIKit

class NoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var weeow: UIImageView!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    @IBOutlet weak var imageYPosition: NSLayoutConstraint!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
