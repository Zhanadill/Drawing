//
//  GradientView.swift
//  Drawing
//
//  Created by Жанадил on 3/4/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup(){
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.bounds = bounds
        
        //let dark = UIColor.blue.cgColor
        //let light = UIColor.cyan.cgColor
        let dark = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
        let light = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1).cgColor
        
        // we added 3 colors in our gradient (we can use 2, 4 and more colors)
        gradientLayer.colors = [dark, light, UIColor.systemPink.cgColor]
        
        //Так мы можем указываем соотношение blue(0:0,1), cyan(0.1:0.5), orange(0.5, 1.0)
        gradientLayer.locations = [0, 0.33, 0.66]
        
        //Сделали так чтобы gradient был слева направо
        //gradientLayer.startPoint = CGPoint(x:0, y:0.5)
        //gradientLayer.endPoint = CGPoint(x:1, y:0.5)
        
        //Gradient будет начинаться с левого верхнего угла и кончаться на правом нижнем
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.anchorPoint = .zero
    }
}
