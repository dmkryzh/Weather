//
//  HourlyForecastChartView.swift
//  Weather
//
//  Created by Dmitrii KRY on 28.06.2021.
//

import Foundation
import UIKit
import SnapKit

class HourlyForecastChartView: UIView {

    var strideX: Double = 0
  
    var timeLine: [String]
    
    var temperature: [Double]
    
    lazy var maxY = tempPoints.max { a, b in a.y < b.y }
    
    lazy var minY = tempPoints.min { a, b in a.y < b.y }
    
    lazy var tempPoints = temperature.map { element -> CGPoint in
        let y = -element * scaledStride + tempMin
        let point  = CGPoint(x: strideX, y: y + 68)
        print(y)
        strideX += 50
        return point
    }
    
    lazy var tempMin = temperature.min()!
    lazy var tempMax = temperature.max()!
    lazy var scaledStride = 50 / (tempMax)
    
    func addPointsTextAndImages() {
        tempPoints.forEach { element in
            let image = UIView()
            image.backgroundColor = .white
            image.layer.borderWidth = 0.5
            image.layer.borderColor = UIColor.blue.cgColor
            image.layer.cornerRadius = 3.5
            image.layer.masksToBounds = true
            image.frame = CGRect(x: element.x, y: element.y - 3.5, width: 7, height: 7)
            self.addSubview(image)
        }
        
        for (index, element) in tempPoints.enumerated() {
            let value = temperature[index]
            let image = UILabel()
            image.font = UIFont(name: "Rubik-Regular", size: 14)
            image.textColor = .black
            image.text = String(format: "%.1f", value)
            image.frame = CGRect(x: element.x, y: element.y - 18, width: 30, height: 14)
            self.addSubview(image)
            
        }
        
        var strideForTimeLine: Double = 0
        
        timeLine.forEach { element in
            let image = UILabel()
            image.font = UIFont(name: "Rubik-Regular", size: 14)
            image.textColor = .black
            image.text = element
            image.frame = CGRect(x: strideForTimeLine, y: 133, width: 40, height: 20)
            self.addSubview(image)
            strideForTimeLine += 50.0
        }
        
        var strideForTimeLineRects: Double = 0
        
        timeLine.forEach { element in
            let image = UIView()
            image.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            image.frame = CGRect(x: strideForTimeLineRects, y: 118, width: 4, height: 8)
            self.addSubview(image)
            strideForTimeLineRects += 50.0
        }
        
        var strideForTimeLinePercents: Double = 0
        
        timeLine.forEach { element in
            let image = UILabel()
            image.font = UIFont(name: "Rubik-Regular", size: 12)
            image.textColor = .black
            image.text = "47%"
            image.frame = CGRect(x: strideForTimeLinePercents, y: 98, width: 25, height: 15)
            self.addSubview(image)
            strideForTimeLinePercents += 50.0
        }
        
        var strideForTimeLineRain: Double = 0
        
        timeLine.forEach { element in
            let image = WeatherIcons.rain.getIcon()
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: strideForTimeLineRain, y: 78, width: 17, height: 20)
            self.addSubview(imageView)
            strideForTimeLineRain += 50.0
        }
    }
    
    override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            drawChart(inContext: context)
            drawTimeLine(inContext: context)
            drawDashedLines(inContext: context)
            drawFilledShape(inContext: context)
        
    }

func drawDashedLines(inContext context: CGContext) {
    context.setLineWidth(0.3)
    context.setStrokeColor(UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor)
    context.setLineDash(phase: 5, lengths: [5,5])
    context.setLineCap(.round)
    
    context.beginPath()
    
    if tempPoints.first!.y >= minY!.y {
        context.move(to: CGPoint(x: 0, y: tempPoints.first!.y))
        context.addLine(to: CGPoint(x: 0, y: maxY!.y))
    }
    context.move(to: CGPoint(x: 0, y: maxY!.y))
    context.addLine(to: CGPoint(x: 400, y: maxY!.y))
    context.strokePath()
}

func drawChart(inContext context: CGContext) {
    
    context.setLineWidth(0.3)
    context.setStrokeColor(UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor)
    context.setLineCap(.round)
    
    
    for _ in tempPoints {
        guard let gradus = tempPoints.first else { continue }
        context.beginPath()
        context.move(to: gradus)
        
        for point in tempPoints.dropFirst() {
            context.addLine(to: point)
        }
        
        context.strokePath()
    }
    
}
    
func drawFilledShape(inContext context: CGContext) {
    
    context.setLineCap(.round)
    
    for _ in tempPoints {
        guard let gradus = tempPoints.first else { continue }
        context.beginPath()
        context.move(to: gradus)
        
        for point in tempPoints.dropFirst() {
            context.addLine(to: point)
        }
        
        context.addLine(to: CGPoint(x: 350, y: maxY!.y))
        context.addLine(to: CGPoint(x: 0, y: maxY!.y))
        context.addLine(to: CGPoint(x: 0, y: tempPoints.first!.y))
        context.setFillColor(UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 0.025).cgColor)
        context.fillPath()
        context.setAlpha(0.5)
        context.strokePath()
    }
}

func drawTimeLine(inContext context: CGContext) {
    
    let startPoint = CGPoint(x: 0, y: 122)
    let endPoint = CGPoint(x: 400, y: 122)
    
    context.setLineWidth(0.3)
    context.setStrokeColor(UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor)
    context.setLineCap(.round)
    
    context.beginPath()
    context.move(to: startPoint)
    context.addLine(to: endPoint)
    context.strokePath()
    
}
    
    init(_ timeline: [String], _ arrayHours: [Double], _ frame: CGRect) {
        self.timeLine = timeline
        temperature = arrayHours
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        addPointsTextAndImages()
    }
    
required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
