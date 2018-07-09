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
    }
    
    func removeTranslucency()  {
        
        self.isTranslucent = true
        self.shadowImage = UIImage()
        self.setBackgroundImage(UIImage(), for: .default)
        
        
//        let view  = UIView()
//        view.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.30)
//        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.height)
//        view.autoresizingMask = [.flexibleWidth]
//        self.addSubview(view)
        
    }
    
    
    
    
}
