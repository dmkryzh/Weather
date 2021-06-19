//
//  DetailedForecastTableViewCell.swift
//  Weather
//
//  Created by Dmitrii KRY on 18.06.2021.
//

import UIKit

class DetailedForecastTableViewCell: UITableViewCell {
    
    private let internalView: UIView = {
        let view = UIView()
        return view
    }()

    
    private let dateLabel: UILabel = {
        let date = Date()
        let view = UILabel()
        view.text = date.getFormattedDate(format: "E d/MM")
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        return view
    }()
    
    private let timeLabel: UILabel = {
        let view = UILabel()
        view.text = "12:00"
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        return view
    }()
    
    private let byFillingLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 14)
  
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "crescent-moon_1")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " Преимуществен.. По ощущению 10")
        completeText.append(textAfterIcon)
        
        view.textAlignment = .left
        view.attributedText = completeText
        
        return view
    }()
    
    private let windLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 14)
  
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "wind-1")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " Ветер")
        completeText.append(textAfterIcon)
        
        view.textAlignment = .left
        view.attributedText = completeText
        
        return view
    }()
    
    private let rainLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 14)
  
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "Frame-5")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " Атмосферные осадки")
        completeText.append(textAfterIcon)
        
        view.textAlignment = .left
        view.attributedText = completeText
        
        return view
    }()
    
    private let cloudsLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 14)
  
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "Frame-3")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        
        let textAfterIcon = NSAttributedString(string: " Облачность")
        completeText.append(textAfterIcon)
        
        view.textAlignment = .left
        view.attributedText = completeText
        
        return view
    }()
    
    private let degreesLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "circle")
        imageAttachment.bounds = CGRect(x: 1, y: 12, width: 3, height: 3)
        
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        let completeText = NSMutableAttributedString(string: "13")
        completeText.append(attachmentString)
        
        view.attributedText = completeText
        return view

    }()
    
    func setConstraints() {
        
        internalView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(internalView.snp.top).offset(15)
            make.width.equalTo(80)
            make.leading.equalTo(internalView.snp.leading).offset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.width.equalTo(47)
            make.leading.equalTo(internalView.snp.leading).offset(16)
        }
        
        degreesLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.width.equalTo(25)
            make.leading.equalTo(internalView.snp.leading).offset(22)
            
        }
        
        byFillingLabel.snp.makeConstraints { make in
            make.top.equalTo(internalView.snp.top).offset(45)
            make.width.equalTo(286)
            make.leading.equalTo(internalView.snp.leading).offset(74)
            
        }
        
        windLabel.snp.makeConstraints { make in
            make.top.equalTo(byFillingLabel.snp.bottom).offset(8)
            make.width.equalTo(100)
            make.leading.equalTo(internalView.snp.leading).offset(74)
            
        }
        
        rainLabel.snp.makeConstraints { make in
            make.top.equalTo(windLabel.snp.bottom).offset(8)
            make.width.equalTo(170)
            make.leading.equalTo(internalView.snp.leading).offset(74)
            
        }
        
        cloudsLabel.snp.makeConstraints { make in
            make.top.equalTo(rainLabel.snp.bottom).offset(8)
            make.width.equalTo(128)
            make.leading.equalTo(internalView.snp.leading).offset(74)
            make.bottom.equalTo(internalView.snp.bottom).inset(8)
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        contentView.addSubview(internalView)
        internalView.addSubviews(dateLabel, timeLabel, degreesLabel, byFillingLabel, windLabel, rainLabel, cloudsLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
