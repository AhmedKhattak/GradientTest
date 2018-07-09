//
//  navbarhieghtextension.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 08/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 500)
    }
}
