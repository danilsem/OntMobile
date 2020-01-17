//
//  CircleView.swift
//  OntMobile
//
//  Created by Admin on 18/12/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CircleView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let path = UIBezierPath(ovalIn: rect)
        
        
        UIColor.systemPurple.withAlphaComponent(0.3).setFill()
        path.fill()
        
    }

}
