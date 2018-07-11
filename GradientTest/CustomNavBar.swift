//
//  CustomNavBar.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 05/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import Foundation

import UIKit

class CustomUINavigationBar: UINavigationBar {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        removeTranslucency()
        setTint(color: UIColor.white)
        
    }
    
    func removeTranslucency()  {
        
        self.isTranslucent = true
        self.shadowImage = UIImage()
        self.setBackgroundImage(UIImage(), for: .default)
    }
    
    func makeGradient() {
        
                let view  = GraphView()
                view.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
                view.autoresizingMask = [.flexibleWidth, .flexibleWidth]
                self.addSubview(view)
        
    }
    
    func setTint(color: UIColor)  {
        self.tintColor = color
    }
    
    
    
    
}
