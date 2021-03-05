//
//  GraphicView.swift
//  Drawing
//
//  Created by Жанадил on 3/5/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

@IBDesignable
class GraphicView: UIView {

    //values that we use to draw a graphic
    var days: [CGFloat] = [4, 3, 0, 6, 5, 10, 8]
    
    
    //number of y axis labels (то есть у нас будет пять текстов-показателей в графе)
    let yDivisions: CGFloat = 5

    
    //margin between lines
    lazy var gap: CGFloat = {
        return bounds.height / (yDivisions + 1)
    }()
    
    
    //averaged value spread over y Divisions (определили среднее значение нашего массива чтобы по нему
    //потом вставлять тексты(показатели))
    lazy var eachLabel: CGFloat = {
        let maxValue = CGFloat(days.max()!)
        let minValue = CGFloat(days.min()!)
        return (maxValue - minValue) / (yDivisions-1)
    }()
    
    
    //column width
    lazy var columnWidth: CGFloat = {
        return bounds.width / CGFloat(days.count)
    }()
    
    
    //we need it to draw a graph
    lazy var data: [CGPoint] = {
        var array = [CGPoint]()
        for(index, day) in days.enumerated(){
            let point = CGPoint(x: columnWidth * CGFloat(index),
                                y: day / eachLabel * gap)
            array.append(point)
        }
        return array
    }()
    
    
    //function that's responsible for drawing
    override func draw(_ rect: CGRect){
        let context = UIGraphicsGetCurrentContext()!
        //добавляем текст
        drawText(context: context)
        
        //рисуем граф
        context.saveGState()
        context.translateBy(x: columnWidth/2 + 10, y: 0)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -bounds.height)
        context.translateBy(x: 0, y: gap)
        
        //add clip
        context.saveGState()
        //На случай если мы не хотим чтобы наш был округленным
        /*context.addLines(between: data)
        context.addLine(to: CGPoint(x: bounds.width - columnWidth, y: 0))
        context.addLine(to: .zero)
        context.closePath()
        context.clip()*/
        
        
        //На случай если мы хотим чтобы граф был округленным
        let clipPath = UIBezierPath()
        clipPath.interpolatePointsWithHermite(interpolationPoints: data)
        clipPath.addLine(to: CGPoint(x: bounds.width - columnWidth, y: 0))
        clipPath.addLine(to: .zero)
        clipPath.close()
        clipPath.addClip()
        
        
        //делаем gradient
        drawGradient(context: context)
        context.restoreGState()
        
        //Это на случай если мы не хотим чтобы наш граф был округленным
        //context.addLines(between: data)
        //context.strokePath()
        
        //Это округляет наш граф
        let path = UIBezierPath()
        path.interpolatePointsWithHermite(interpolationPoints: data)
        path.stroke()
        
        context.restoreGState()
    }
    
    
    //(создаем gradient и используем его как бэкграунд)
    func drawGradient(context: CGContext){
        //Задали параметры gradient-a
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors: NSArray = [#colorLiteral(red: 0.5706732273, green: 0.9352992177, blue: 0.9688987136, alpha: 1).cgColor, #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor]
        let locations: [CGFloat] = [0.0, 0.75]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors,
                                  locations: locations)
        
        //Создали обычный, квадратно-линейный gradient
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient!,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        
        
        //Создали круглый gradient где цвета меняются начиная с центра
        /*let startCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let startRadius: CGFloat = 30
        let endCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let endRadius: CGFloat = 150
        context.drawRadialGradient(gradient!,
                                   startCenter: startCenter,
                                   startRadius: startRadius,
                                   endCenter: endCenter,
                                   endRadius: endRadius,
                                   options: [])*/
        
        
        //Создали круглый gradient, который похож на шар на которого падает свет
        /*let startCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let startRadius: CGFloat = 20
        let endCenter = CGPoint(x: bounds.midX + 30, y: bounds.midY + 30)
        let endRadius: CGFloat = 120
        context.drawRadialGradient(gradient!,
                                   startCenter: startCenter,
                                   startRadius: startRadius,
                                   endCenter: endCenter,
                                   endRadius: endRadius,
                                   options: [])*/
    }
    
    
    //создаем тексты-показатели
    func drawText(context: CGContext){
        //Указали параметры текста
        let font = UIFont(name: "Avenir-Light", size: 12)
        let attributes = [NSAttributedString.Key.font: font]
        
        //добавляем 5 текстов и линию для каждого текста поочередно (при кажой итерации будет выполняться translate по Y и будет меняться значение текста)
        let maxValue = CGFloat(days.max()!)
        context.saveGState()
        for i in 0..<5{
            context.translateBy(x: 0, y: gap)
            
            //добавили линию
            context.setStrokeColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor)
            context.setLineWidth(1)
            context.addLines(between: [CGPoint(x: 35, y: 0),
                                       CGPoint(x: bounds.width, y: 0)])
            context.strokePath()
            
            //создаем текст и выравниваем его по линии
            let text = "\(maxValue - eachLabel * CGFloat(i))" as NSString
            let size = text.size(withAttributes: attributes)
            text.draw(at: CGPoint(x: 6, y: -size.height/2), withAttributes: attributes)
        }
        context.restoreGState()
    }
}
