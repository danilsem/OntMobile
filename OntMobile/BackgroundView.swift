//
//  BackgroundView.swift
//  OntMobile
//
//  Created by Admin on 17/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        setup(rect: rect)
    }
    
    func colorWithGradient(frame: CGRect, colors: [UIColor]) -> UIColor {
        
        // create the background layer that will hold the gradient
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = frame
        backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
         
        // we create an array of CG colors from out UIColor array
        let cgColors = colors.map({$0.cgColor})
        
        backgroundGradientLayer.colors = cgColors
        
        UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
        backgroundGradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: backgroundColorImage!)
    }
    
    func setup(rect: CGRect) {
        let path = UIBezierPath()
        
        let width = Int(rect.width)
        let height = Int(rect.height)
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height/2))
        path.addQuadCurve(to: CGPoint(x: width/2, y: height/4*3+30), controlPoint: CGPoint(x: width/4*3+70, y: height/4*3+20))
        //path.addQuadCurve(to: CGPoint(x: 0, y: height), controlPoint: CGPoint(x: 100, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        
        path.close()
        
        //UIColor.systemBlue.setFill()
        colorWithGradient(frame: rect, colors: [UIColor.systemBlue, UIColor.systemPurple]).setFill()
        path.fill()
        
        
        path.close()
    }
}
