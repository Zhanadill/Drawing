//
//  BudgetView.swift
//  Drawing
//
//  Created by Жанадил on 3/3/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

@IBDesignable
class BudgetView: UIView {
    let label = UILabel()
    
    // stepper is 0 to 1
    let stepper = UIStepper()
    
    let step: Double = 100  //go up by 100$ at a time
    // specified max_value of stepper
    let maxValue:Double = 4
    
    var currentValue: Double = 0 {
        didSet{
            //specified calculation
            label.text = "\(Int(currentValue * step))"
            
            //настроили анимацию которая будет выполняться по нажатию stepper-a
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = 1.0
            foregroundLayer.strokeEnd = CGFloat(currentValue/maxValue)
            foregroundLayer.add(animation, forKey: "stroke")
        }
    }
    
    //backgroundLayer
    var backgroundLayer = ArcLayer(color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
    //foregroundLayer
    var foregroundLayer = ArcLayer(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    //@IBDesignable
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup() {
        buildInterface()
        // we set layers
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
        foregroundLayer.strokeEnd = 0
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        backgroundLayer.bounds = bounds
        foregroundLayer.bounds = bounds
    }
    
    //MARK: Subviews
    @objc func handleStepper(_ stepper: UIStepper){
        currentValue = stepper.value
    }
    
    func buildInterface(){
        //We set parameters of stepper
        stepper.minimumValue = 0
        stepper.maximumValue = maxValue
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.addTarget(self, action: #selector(handleStepper(_:)), for: .valueChanged)
        stepper.isContinuous = true
        
        //We added stepper
        addSubview(stepper)
        let stepCenterX = stepper.centerXAnchor.constraint(equalTo: centerXAnchor)
        let stepBottom = stepper.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([stepCenterX, stepBottom])
        
        //We set parameters of label
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //We added label
        addSubview(label)
        let labelCenterX = label.centerXAnchor.constraint(equalTo: centerXAnchor)
        let labelCenterY = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([labelCenterX, labelCenterY])
    }
}



class ArcLayer: CAShapeLayer {
    init(color: UIColor){
        super.init()
        strokeColor = color.cgColor
        lineWidth = 20
        fillColor = nil
        lineCap = CAShapeLayerLineCap.round
    }
    
    override var bounds: CGRect {
        didSet {
            buildLayer()
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) hasn't been implemented")
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    //Here we dont consider angles btw 45 and 130
    func buildLayer(){
        let startAngle = 0.75 * CGFloat.pi
        let endAngle = 0.25 * CGFloat.pi
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.width * 0.35
        let path = UIBezierPath(arcCenter: center,
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        self.path = path.cgPath
        position = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
