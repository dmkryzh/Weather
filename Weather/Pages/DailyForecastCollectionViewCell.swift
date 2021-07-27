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
    
    let imageForIcon: NSTextAttachment = {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = WeatherIcon.fewClouds.getIconImage()
        imageAttachment.bounds = CGRect(x: 0, y: -4, width: 15, height: 17)
        return imageAttachment
    }()
    
    let icon: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 12)
        view.textColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        view.textAlignment = .left
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        view.text = "Местами дождь"
        view.textAlignment = .left
        return view
    }()
    
    let chevron: UIImageView = {
        let image = UIImage(systemName: "chevron.right")
        let view = UIImageView(image: image)
        view.tintColor = .black
        return view
    }()
    
    let imageAttachment: NSAttributedString = {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "circle")
        imageAttachment.bounds = CGRect(x: 1, y: 12, width: 5, height: 5)
        let attachment = NSAttributedString(attachment: imageAttachment)
        return attachment
    }()
    
    lazy var tempMin: NSMutableAttributedString = {
        let minText = NSMutableAttributedString()
        return minText
    }()
    
    lazy var tempMax: NSMutableAttributedString = {
        let maxText = NSMutableAttributedString()
        return maxText
    }()
    
    lazy var temperature: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        return view
    }()
    
    func setConstraints() {
        date.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.width.equalTo(53)
            make.height.equalTo(19)
        }
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(date.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(18)
        }
        
        title.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
            make.width.equalTo(170)
            make.height.equalTo(22)
        }
        
        temperature.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.width.equalTo(70)
            make.height.equalTo(22)
        }
        
        chevron.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
            make.width.equalTo(6)
            make.height.equalTo(10)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        backgroundColor = .lightGray
        contentView.addSubviews(date, icon, title, temperature, chevron)
        setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
