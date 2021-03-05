//
//  CustomButton.swift
//  Drawing
//
//  Created by Жанадил on 3/3/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width * 0.5
        layer.backgroundColor = UIColor.red.cgColor
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 1
        layer.shadowRadius = 1
    }
    
    
    
    override func draw(_ rect: CGRect) {
         let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.width / 3, y: rect.height / 3))
        path.addLine(to: CGPoint(x: 2 * (rect.width / 3), y: 2 * (rect.height / 3)))
        
        path.move(to: CGPoint(x: 2 * (rect.width / 3), y: rect.height / 3))
        path.addLine(to: CGPoint(x: rect.width / 3, y: 2 * (rect.height / 3)))
        
        path.close()
        UIColor.black.setStroke()
        path.lineWidth = 3
        UIColor.black.setFill()
        path.fill()
        
        path.stroke()
    }
}
