//
//  UIControlInteractionManager.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 12/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import Foundation
import UIKit

class UIControlInteractionManager {
    
    
    // set to uicontrol so uiviews that are not controls are not accidentally added to the controls array
    private(set)  var controls: [UIControl] = []
    
    func removeControl(control: UIControl) {
        let index = controls.index { (view) -> Bool in
            return view.isEqual(control)
        }
        if let index = index  {
            controls.remove(at: index)
        }
    }
    
    func addControl(control: UIControl)  {
        controls.append(control)
    }
    
    func addControls(controls: [UIControl])  {
        self.controls.append(contentsOf: controls)
    }
    
    func disableControlsInteraction() {
        controls.forEach { (control) in
            control.isUserInteractionEnabled = false
        }
    }
    
    func enableControlsInteraction() {
        controls.forEach { (control) in
            control.isUserInteractionEnabled = true
        }
    }
    
    
    func disableControls() {
        controls.forEach { (control) in
            control.isEnabled = false
            
        }
    }
    
    func enableControls() {
        controls.forEach { (control) in
            
            control.isEnabled = true
        }
    }
    
    
    
    
    
    
    
}
