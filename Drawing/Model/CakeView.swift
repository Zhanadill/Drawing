//
//  CakeView.swift
//  Drawing
//
//  Created by Жанадил on 3/4/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

@IBDesignable
class CakeView: UIView {
    var image: UIImage?
    
    //Мы создали Х (рисунок)
    var cross: UIImage{
        let size = 40
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
        return renderer.image { (context) in
            let cgcontext = context.cgContext 
            cgcontext.addLines(between: [.zero, CGPoint(x: size, y: size)])
            cgcontext.addLines(between: [CGPoint(x: size, y: 0),
                                         CGPoint(x: 0, y: size)])
            cgcontext.setStrokeColor(UIColor.white.cgColor)
            cgcontext.strokePath()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        image = drawCupcake(rect: bounds)
    }

    @IBInspectable var rating: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //Мы создали Cake
    func drawCupcake(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let image = renderer.image { canvas in
            //Bottom of Cake
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 10, y: rect.height/2))
            path.addLine(to: CGPoint(x: rect.width/5, y: rect.height - 10))
            path.addLine(to: CGPoint(x: 4 * (rect.width/5), y: rect.height - 10))
            path.addLine(to: CGPoint(x: rect.width - 10, y: rect.height/2))
            path.addLine(to: CGPoint(x: 10, y: rect.height/2))
            path.close()
            UIColor.black.setStroke()
            path.lineWidth = 3
            #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).setFill()
            path.fill()
            
            path.stroke()
            
            
            //Top of Cake
            let top = UIBezierPath()
            top.move(to: CGPoint(x: 10, y: rect.height/2))
            var controlPoint1 = CGPoint(x: 10, y: rect.height/3)
            var controlPoint2 = CGPoint(x: rect.width/6, y: rect.height/6)
            top.addCurve(to: CGPoint(x: rect.width/2,y: 10), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            controlPoint1 = CGPoint(x: 5 * (rect.width/6), y: rect.height/6)
            controlPoint2 = CGPoint(x: rect.width - 10, y: rect.height/3)
            top.addCurve(to: CGPoint(x: rect.width - 10,y: rect.height/2), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            
            top.close()
            top.lineWidth = 3
            #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1).setFill()
            top.fill()
            top.stroke()
        }
        return image
    }
    
    
    
    override func draw(_ rect: CGRect) {
        //we created context
        let context = UIGraphicsGetCurrentContext()
        
        //we decreased size of our context
        //В данном случае в наш контекст вмещается 5 обьектов(0.20, 0.20, 0.20, 0.20, 0.20)
        context?.saveGState()
        context?.scaleBy(x: 0.20, y: 0.20)
        
        //Теперь у нас есть 5 cake
        context?.saveGState()
        for _ in 0..<5 {
            image?.draw(at: .zero)
            context?.translateBy(x: rect.width, y: 0)
        }
        context?.restoreGState()
        context?.restoreGState()
        
        
        //в зависимости от рэйтинга у нас будут высвечиваться cakes
        context?.saveGState()
        context?.scaleBy(x: 0.20, y: 0.20)
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -rect.height)
        for i in 0..<5{
            if i >= rating {
                context?.saveGState()
                context?.clip(to: rect, mask: image!.cgImage!)
                UIColor.red.setFill()
                UIRectFill(rect)
                cross.drawAsPattern(in: rect)
                context?.restoreGState()
            }
            context?.translateBy(x: rect.width, y:0)
        }
        context?.restoreGState()
        
        //рисуем сам Cake
        //image?.draw(at: .zero)
        //создали контекст
        //let context = UIGraphicsGetCurrentContext()
        //context?.saveGState()
        //перевернули контекст потому что до этого он выводился в перевернутом виде
        //context?.scaleBy(x: 1, y: -1)
        //сделали так чтобы контекст был над рисунком
        //context?.translateBy(x: 0, y: -rect.height)
        //Сделали так чтобы Context принимал форму нашего Cake
        //context?.clip(to: rect, mask: image!.cgImage!)
        //задали красный бэкграунд нашему View
        //UIColor.red.setFill()
        //UIRectFill(rect)
        //рисуем решетку
        //cross.drawAsPattern(in: rect)
        //context?.restoreGState()
               
        //image?.draw(at: .zero)
    }
    
    
    //Gesture у нас автоматически меняет параметры контекста когда рэйтинг будет меняться
    //Во время работы приложения
    @objc func handleTap(gesture: UITapGestureRecognizer){
        let width = bounds.width * 0.20
        let location = gesture.location(in: self).x / width
        rating = Int(location) + 1
    }
    
    override func didMoveToWindow(){
        super.didMoveToWindow()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:))))
    }
}
