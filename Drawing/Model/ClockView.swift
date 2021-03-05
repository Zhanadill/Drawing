//
//  ClockView.swift
//  Drawing
//
//  Created by Жанадил on 3/4/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

@IBDesignable
class ClockView: UIView {
    //background layer
    var dial = CAShapeLayer()
    //foreground layer that's responsible for arrow
    var pointer = CAShapeLayer()
    // layer that's responsible for numbers
    var numbersLayer = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    //Function that is responsible for numbers
    func drawNumbers(){
        //we specified size of that layer as size of our view
        numbersLayer.bounds = bounds
        //Разместили layer по центру
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        numbersLayer.position = center
        
        //it rotates context and draws numbers
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { (canvas) in
            let context = canvas.cgContext
            
            for i in 1...12{
                context.translateBy(x: center.x, y: center.y)
                context.rotate(by: CGFloat.pi * 2/12)
                context.translateBy(x: -center.x, y: -center.y)
                draw(number: i)
            }
        }
        numbersLayer.contents = image.cgImage
    }
    
    // We set border_color, content_color and shadow effects
    private func setup(){
        layer.addSublayer(dial)
        layer.addSublayer(pointer)
        layer.addSublayer(numbersLayer)
        dial.strokeColor = UIColor.black.cgColor
        dial.fillColor = UIColor.white.cgColor
        
        dial.shadowColor = UIColor.gray.cgColor
        dial.shadowOpacity = 0.7
        dial.shadowRadius = 8
        dial.shadowOffset = .zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // we created border path around our content
        let dialPath = UIBezierPath(ovalIn: bounds)
        dial.path = dialPath.cgPath
        //we created arrow and set parameters
        let path = buildArrow(width: 10, length: bounds.midX - 20, depth: 20)
        pointer.path = path.cgPath
        pointer.strokeColor = UIColor.darkGray.cgColor
        pointer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        pointer.lineWidth = 4
        pointer.lineCap = CAShapeLayerLineCap.round
        
        drawNumbers()
        
        //We set animation
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 60
        animation.fromValue = 0
        animation.toValue = Float.pi * 2
        animation.repeatCount = .greatestFiniteMagnitude
        pointer.add(animation, forKey: "time")
    }
    
    //function that's responsible for creation of arrow
    func buildArrow(width: CGFloat, length: CGFloat, depth: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: .zero)
        let endPoint = CGPoint(x: 0, y: -length)
        path.addLine(to: endPoint)
        
        path.move(to: CGPoint(x: 0-width, y: endPoint.y + depth))
        path.addLine(to: endPoint)
        path.move(to: CGPoint(x: width, y: endPoint.y + depth))
        path.addLine(to: endPoint)
        
        return path
    }
    
    //method for drawing the numbers
    func draw(number: Int){
        let string = "\(number)" as NSString
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Avenir-Heavy", size: 18)!]
        let size = string.size(withAttributes: attributes)
        string.draw(at: CGPoint(x: bounds.width/2 - size.width/2, y: 10), withAttributes: attributes)
        
    }
}
