//
//  SketchGradient.swift
//  GradientTest
//
//  Created by Ahmed Khattak on 10/07/2018.
//  Copyright © 2018 Ahmed Khattak. All rights reserved.
//

import Foundation
import UIKit

//class SketchGradientLayer: CALayer {
//    
//    public var colors = [UIColor.hexStringToUIColor(hex: "#345EF2").cgColor, UIColor.hexStringToUIColor(hex: "#7C6CF2").cgColor]
//    
//    public var locations: [CGFloat] = [0.0,1.0]
//    public var startPoint = CGPoint(x: 1.0, y: 1.0)
//    public var endPoint = CGPoint(x: 0.0, y: 0.0)
//    
//    required override init() {
//        super.init()
//        needsDisplayOnBoundsChange = true
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    required override init(layer: Any) {
//        super.init(layer: layer)
//    }
//    
//    
//    
//    
//    override func draw(in ctx: CGContext) {
//        
//        
//        
//        // 1
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        
//        
//        
//        // 2
//        let gradient = CGGradient(colorsSpace: colorSpace,
//                                  colors: colors as CFArray,
//                                  locations: locations)!
//        
//        // 3
//        let startPoint =  CGPoint.zero
//        let endPoint =  CGPoint(x: self.frame.width/2, y: self.frame.height/2)
//        
//        //4
//        ctx.drawLinearGradient(gradient,
//                               start: startPoint,
//                               end: endPoint,
//                               options: [.drawsAfterEndLocation,.drawsBeforeStartLocation])
//        
//    }
//}


import UIKit

@IBDesignable class GraphView: UIView {
    
    // 1
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    @IBInspectable  var colorLocations: [CGFloat] = [0.0, 1.0]
    
    override func draw(_ rect: CGRect) {
        
        // 2
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        colorLocations = [0.0, 1.0]
        
        // 5
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: bounds.width, y: 0)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
}


extension UIView {

    // https://stackoverflow.com/a/49556261/8685328
  
        func applyTransform(withScale scale: CGFloat, anchorPoint: CGPoint) {
            layer.anchorPoint = anchorPoint
            let scale = scale != 0 ? scale : CGFloat.leastNonzeroMagnitude
            // The real magic happens on below 2 lines !!!
            let xPadding = 1/scale * (anchorPoint.x - 0.5)*bounds.width
            let yPadding = 1/scale * (anchorPoint.y - 0.5)*bounds.width
            
            transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: xPadding, y: yPadding)
            
        
        }
    
}
