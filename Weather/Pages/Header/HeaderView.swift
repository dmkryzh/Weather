//
//  HeaderView.swift
//  Weather
//
//  Created by Dmitrii KRY on 11.06.2021.

import UIKit
import Foundation

class HeaderView: UIView {
    
    var viewModel: HeaderViewModel
    
    lazy var dawnTime: UILabel = {
        let label = UILabel()
        label.text = viewModel.sundawn?.getFormattedDate(format: "HH:mm")
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.frame = CGRect(x: 0, y: 0, width: 40, height: 19)
        return label
    }()
    
    lazy var sunsetTime: UILabel = {
        let label = UILabel()
        label.text = viewModel.sunset?.getFormattedDate(format: "HH:mm")
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.frame = CGRect(x: 0, y: 0, width: 40, height: 19)
        return label
    }()
    
    lazy var imageGradus: NSAttributedString = {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "circle")?.maskWithColor(color: .white)
        imageAttachment.bounds = CGRect(x: 3, y: 24, width: 5, height: 5)
        
        let string = NSAttributedString(attachment: imageAttachment)
        return string
    }()
    
    lazy var currentTemperature: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 55, height: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Rubik-Regular", size: 36)
        return label
        
    }()
    
    let secondaryTemperature: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 48, height: 22)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "circle")?.maskWithColor(color: .white)
        imageAttachment.bounds = CGRect(x: 2, y: 14, width: 4, height: 4)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "7")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " /13")
        completeText.append(textAfterIcon)
        completeText.append(attachmentString)
        
        
        label.attributedText = completeText
        return label
    }()
    
    let weatherStateText: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.numberOfLines = 1
        label.frame = CGRect(x: 0, y: 0, width: 227, height: 20)
        label.textAlignment = .center
        return label
    }()
    
    let cloudText: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 35, height: 18))
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "Group")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 22, height: 18)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " 0")
        completeText.append(textAfterIcon)
        
        label.textAlignment = .center
        label.attributedText = completeText
        return label
    }()
    
    let windText: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 66, height: 18))
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "wind-1")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 21, height: 16)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " 3 м\\с")
        completeText.append(textAfterIcon)
        
        label.textAlignment = .center
        label.attributedText = completeText
        
        return label
    }()
    
    lazy var humidityText: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 45, height: 18))
        label.textColor = .white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "Frame-5")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 13, height: 16)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " 75%")
        completeText.append(textAfterIcon)
        
        label.textAlignment = .center
        label.attributedText = completeText
        
        return label
    }()
    
    
    lazy var weatherStackIcons: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cloudText, windText, humidityText])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 20
        stack.frame = CGRect(x: 0, y: 0, width: 188, height: 30)
        return stack
    }()
    
    let dawnTimeIcon: UIImageView = {
        let color = UIColor(red: 0.967, green: 0.868, blue: 0.004, alpha: 1)
        let image = UIImage(named: "dawn")?.maskWithColor(color: color)
        let label = UIImageView(image: image)
        label.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        label.tintColor = color
        return label
    }()
    
    let sunsetTimeIcon: UIImageView = {
        let color = UIColor(red: 0.967, green: 0.868, blue: 0.004, alpha: 1)
        let image = UIImage(named: "sunset")?.maskWithColor(color: color)
        let label = UIImageView(image: image)
        label.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        return label
    }()
    
    var date = Date()
    
    lazy var currentFullDate: UILabel = {
        let color = UIColor(red: 0.967, green: 0.868, blue: 0.004, alpha: 1)
        let formate = date.getFormattedDate(format: "HH:mm, E d MMM")
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        label.text = formate
        label.textColor = color
        label.textAlignment = .center
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        return label
    }()
    
    func setFrames() {
        dawnTime.frame.origin.x = self.frame.origin.x + 17
        dawnTime.frame.origin.y = self.frame.origin.y + 167
        
        sunsetTimeIcon.frame.origin.x = dawnTime.frame.maxX + 248
        sunsetTimeIcon.frame.origin.y = self.frame.origin.y + 145
        
        sunsetTime.frame.origin.x = dawnTime.frame.maxX  + 240
        sunsetTime.frame.origin.y = self.frame.origin.y + 166
        
        secondaryTemperature.frame.origin.x = dawnTime.frame.maxX + 95
        secondaryTemperature.frame.origin.y = self.frame.origin.y + 33
        
        currentTemperature.frame.origin.x = dawnTime.frame.maxX  + 92
        currentTemperature.frame.origin.y = self.frame.origin.y + 58
        
        weatherStateText.frame.origin.x = dawnTime.frame.maxX  + 4
        weatherStateText.frame.origin.y = self.frame.origin.y + 103
        
        dawnTimeIcon.frame.origin.x = dawnTime.frame.minX + 8
        dawnTimeIcon.frame.origin.y = self.frame.origin.y + 145
        
        weatherStackIcons.frame.origin.x = dawnTime.frame.maxX + 23
        weatherStackIcons.frame.origin.y = self.frame.origin.y + 131
        
        currentFullDate.frame.origin.x = dawnTime.frame.maxX + 42
        currentFullDate.frame.origin.y = self.frame.origin.y + 171
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: CGRect(x: 33, y: 17, width: 280, height: 246))
        
        let clip = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 344, height: 140))
        
        let color = UIColor(red: 0.967, green: 0.868, blue: 0.004, alpha: 1)
        
        clip.addClip()
        path.lineWidth = 3
        path.lineCapStyle = .round
        color.setStroke()
        path.stroke()
        
    }
    
    init(_ vm: HeaderViewModel, _ city: String?) {
        
        viewModel = vm
        super.init(frame: CGRect(x: 0, y: 0, width: 344, height: 212))
        backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.addSubviews(secondaryTemperature, currentTemperature, weatherStateText, dawnTimeIcon, sunsetTimeIcon, weatherStackIcons, currentFullDate, dawnTime, sunsetTime)
        setFrames()
        
        guard let city = city else { return }
        
        viewModel.getCurrentForecast(city: city, forecastType: .current) { [self] in
            
            dawnTime.text = viewModel.sundawn?.getFormattedDate(format: "HH:mm")
            sunsetTime.text = viewModel.sunset?.getFormattedDate(format: "HH:mm")
            
            let currentTempText = NSMutableAttributedString(string: "")
            currentTempText.append(NSAttributedString(string: "\(Int(viewModel.currentTemp ?? 0))"))
            currentTempText.append(imageGradus)
            
            currentTemperature.attributedText = currentTempText
            weatherStateText.text = viewModel.title
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
