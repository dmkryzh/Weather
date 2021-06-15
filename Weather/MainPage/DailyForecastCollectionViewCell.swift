//
//  DailyForecastCollectionViewCell.swift
//  Weather
//
//  Created by Dmitrii KRY on 14.06.2021.
//

import UIKit

class DailyForecastCollectionViewCell: UICollectionViewCell {
    
    let date: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        view.text = "17/04"
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        return view
    }()
    
    let rain: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 12)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "Group")
        imageAttachment.bounds = CGRect(x: 0, y: -4, width: 15, height: 17)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " 57%")
        completeText.append(textAfterIcon)
        
        view.textAlignment = .center
        view.attributedText = completeText
        
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        view.text = "Местами дождь"
        view.textAlignment = .center
        
        return view
    }()
    
    let temperature: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "circle")
        imageAttachment.bounds = CGRect(x: 1, y: 12, width: 5, height: 5)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "4")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " -11")
        completeText.append(textAfterIcon)
        completeText.append(attachmentString)
        
        
        view.attributedText = completeText
        
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        date.frame.origin.x = contentView.frame.minX + 10
        date.frame.origin.y = contentView.frame.minY + 6
        date.frame.size = CGSize(width: 53, height: 19)
        
        rain.frame.origin.x = contentView.frame.minX + 10
        rain.frame.origin.y = contentView.frame.minY + 30
        rain.frame.size = CGSize(width: 45, height: 18)
        
        title.frame.origin.x = contentView.frame.minX + 66
        title.frame.origin.y = contentView.frame.minY + 19
        title.frame.size = CGSize(width: 206, height: 19)
        
        temperature.frame.origin.x = contentView.frame.minX + 275
        temperature.frame.origin.y = contentView.frame.minY + 17
        temperature.frame.size = CGSize(width: 50, height: 22)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        backgroundColor = .lightGray
        contentView.addSubviews(date, rain, title, temperature)
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
