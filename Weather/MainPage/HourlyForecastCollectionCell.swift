//
//  HourlyForecastCollectionCell.swift
//  Weather
//
//  Created by Dmitrii KRY on 13.06.2021.
//

import Foundation
import UIKit

class HourlyForecastCollectionCell: UICollectionViewCell {
    
    let backgroundLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: 42, height: 83)
        let firstColor = UIColor(red: 0.246, green: 0.398, blue: 0.808, alpha: 0.58).cgColor
        let secondColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        layer.colors = [firstColor, secondColor]
        return layer
    }()
    
    private lazy var forecastSmall: UIView = {
        let time = UILabel(frame: CGRect(x: 0, y: 0, width: 32, height: 18))
        time.text = "15:00"
        time.textAlignment = .center
        time.textColor = .white
        time.font = UIFont(name: "Rubik-Regular", size: 12)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "circle")?.maskWithColor(color: .white)
        imageAttachment.bounds = CGRect(x: 1, y: 10, width: 3, height: 3)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "13")
        completeText.append(attachmentString)
        
        let temparature = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 18))
        temparature.attributedText = completeText
        temparature.textAlignment = .center
        temparature.textColor = .white
        temparature.font = UIFont(name: "Rubik-Regular", size: 16)
        
        
        let image = UIImage(named: "Frame")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        imageView.backgroundColor = .clear
        
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: 42, height: 83))
        view.layer.cornerRadius = 22
        view.clipsToBounds = true
        view.layer.addSublayer(backgroundLayer)
        
        view.addSubviews(imageView, time, temparature)
        
        view.subviews[0].center = view.center
        
        view.subviews[1].frame.origin.x = view.frame.minX + 5
        view.subviews[1].frame.origin.y = view.frame.minY + 8
        
        view.subviews[2].frame.origin.x = view.frame.minX + 10
        view.subviews[2].frame.origin.y = view.subviews[0].frame.maxY + 4
        
        return view
    }()
    
    func setFrame() {
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 42, height: 83))
        addSubview(forecastSmall)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
