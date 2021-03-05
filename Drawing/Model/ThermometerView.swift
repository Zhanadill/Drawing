//
//  ThermometerView.swift
//  Drawing
//
//  Created by Жанадил on 3/3/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

@IBDesignable
class ThermometerView: UIView {
    //thermometer layer
    let thermoLayer = CAShapeLayer()
    //layer that shows result of thermometer
    let levelLayer = CAShapeLayer()
    //layer that merges two previous layers
    let maskLayer = CAShapeLayer()
    
    var lineWidth: CGFloat {
        return bounds.width / 3
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        setup()
    }
    
    //Цвет thermometer layer будет меняться в зависимости от результата термометра
    @IBInspectable var level: CGFloat = 0.5 {
        didSet {
            if level < 0.5 {
                thermoLayer.fillColor = UIColor.red.cgColor
            }else{
                thermoLayer.fillColor = UIColor.green.cgColor
            }
        }
    }
    
    //Сделали так чтобы эти изменения были видны и в Interface Builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup(){
        layer.addSublayer(thermoLayer)
        layer.addSublayer(levelLayer)
        let width = bounds.width - lineWidth
        let height = bounds.height - lineWidth/2
        //добавили круговую рамочку
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: height-width, width: width, height: width))
        //добавили path который направлен на вверх
        path.move(to: CGPoint(x: width/2, y: height - width))
        path.addLine(to: CGPoint(x: width/2, y: 10))
        //Настроили path
        thermoLayer.path = path.cgPath
        //задали цвет рамочке
        thermoLayer.strokeColor = UIColor.darkGray.cgColor
        //указали радиус рамочки
        thermoLayer.lineWidth = width/7
        //позиционировали по Х
        thermoLayer.position.x = lineWidth/2
        //сделали так чтобы край path-а который направлен на вверх был круглым
        thermoLayer.lineCap = CAShapeLayerLineCap.round
        
        //задали параметры maskLayer
        maskLayer.path = thermoLayer.path
        maskLayer.lineWidth = thermoLayer.lineWidth
        maskLayer.lineCap = thermoLayer.lineCap
        maskLayer.position = thermoLayer.position
        maskLayer.strokeColor = thermoLayer.strokeColor
        maskLayer.lineWidth = thermoLayer.lineWidth - 6
        maskLayer.fillColor = nil
            
        //we called function that shows the result
        buildLevelLayer()
        
        //сделали так чтобы часть levelLayer, которая находится за пределами maskLayer-а, не была видна
        levelLayer.mask = maskLayer
        
        //настроили это для того чтобы можно было вручную менять результат во время работы приложения
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        addGestureRecognizer(pan)
    }
    
    //layer that shows result of our thermometer
    private func buildLevelLayer(){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.midX, y: 0))
        levelLayer.strokeColor = UIColor.white.cgColor
        levelLayer.path = path.cgPath
        levelLayer.lineWidth = bounds.width
        //Мы сделали так чтобы линия кончалась в зависимости от значения результата
        levelLayer.strokeEnd = level
    }
    
    
    //функция которая меняет level и настраивает анимацию
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: gesture.view)
        let percent = translation.y / bounds.height
        
        level = max(0, min(1, levelLayer.strokeEnd - percent))
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        levelLayer.strokeEnd = level
        CATransaction.commit()
        
        gesture.setTranslation(.zero, in: gesture.view)
    }
}
