//
//  TestView.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 11/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import UIKit

@IBDesignable class TestView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    @IBInspectable var anchorPoint: CGPoint = CGPoint.init(x: 0.5, y: 0.5) {
        didSet{
            layoutIfNeeded()
            self.layer.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.anchorPoint = anchorPoint
    }
    
   
    
    
    
    
    
}
