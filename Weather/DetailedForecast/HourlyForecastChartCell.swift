//
//  HourlyForecastChartCell.swift
//  Weather
//
//  Created by Dmitrii KRY on 28.06.2021.
//

import Foundation
import UIKit
import SnapKit

class HourlyForecastChartCell: UICollectionViewCell {
    
    
    var strideX: Double = 0
    
    lazy var tempPoints = temperature.map { element -> CGPoint in
        let point  = CGPoint(x: strideX, y: element)
        strideX += 50
        return point
    }
    
    var temperature = [29.2, 24.0, 25.0, 50.1, 27.8, 26.9, 24.2, 21.0]
    
    var timeLine = ["12:00", "15:00", "19:00", "21:00", "00:00", "03:00", "06:00", "08:00"]
    
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
        
        tempPoints.forEach { element in
            let image = UILabel()
            image.font = UIFont(name: "Rubik-Regular", size: 14)
            image.textColor = .black
            image.text = String(describing: element.y)
            image.frame = CGRect(x: element.x, y: element.y - 22, width: 30, height: 20)
            self.addSubview(image)
        }
        
        var strideForTimeLine: Double = 0
        
        timeLine.forEach { element in
            let image = UILabel()
            image.font = UIFont(name: "Rubik-Regular", size: 14)
            image.textColor = .black
            image.text = element
            image.frame = CGRect(x: strideForTimeLine, y: 128, width: 40, height: 20)
            self.addSubview(image)
            strideForTimeLine += 50.0
        }
        
        var strideForTimeLineRects: Double = 0
        
        timeLine.forEach { element in
            let image = UIView()
            image.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
            image.frame = CGRect(x: strideForTimeLineRects, y: 108, width: 4, height: 8)
            self.addSubview(image)
            strideForTimeLineRects += 50.0
        }
        
        var strideForTimeLinePercents: Double = 0
        
        timeLine.forEach { element in
            let image = UILabel()
            image.font = UIFont(name: "Rubik-Regular", size: 12)
            image.textColor = .black
            image.text = "47%"
            image.frame = CGRect(x: strideForTimeLinePercents, y: 88, width: 25, height: 15)
            self.addSubview(image)
            strideForTimeLinePercents += 50.0
        }
        
        var strideForTimeLineRain: Double = 0
        
        timeLine.forEach { element in
            let image = WeatherIcons.rain.getIcon()
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: strideForTimeLineRain, y: 68, width: 17, height: 20)
            self.addSubview(imageView)
            strideForTimeLineRain += 50.0
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        drawChart(inContext: context)
        drawTimeLine(inContext: context)
        drawDashedLines(inContext: context)
        
    }
    
    func drawDashedLines(inContext context: CGContext) {
        context.setLineWidth(0.3)
        context.setStrokeColor(UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor)
        context.setLineDash(phase: 5, lengths: [5,5])
        context.setLineCap(.round)
        context.beginPath()
        
        let maxY = temperature.max()
        let minY = temperature.min()
        context.move(to: CGPoint(x: 0, y: minY!))
        context.addLine(to: CGPoint(x: 0, y: maxY!))
        context.addLine(to: CGPoint(x: 400, y: maxY!))
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
    
    func drawTimeLine(inContext context: CGContext) {
        
        let startPoint = CGPoint(x: 0, y: 112)
        let endPoint = CGPoint(x: 400, y: 112)
        
        context.setLineWidth(0.3)
        context.setStrokeColor(UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor)
        context.setLineCap(.round)
        
        context.beginPath()
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        context.strokePath()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        addPointsTextAndImages()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
