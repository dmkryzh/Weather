//
//  DailyForecastHeaderCell.swift
//  Weather
//
//  Created by Dmitrii KRY on 24.06.2021.
//

import Foundation
import UIKit
import SnapKit

class DailyForecastHeaderCell: UITableViewHeaderFooterView {
    
    var header: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        view.textAlignment = .left
        return view
    }()
    
    let centralTemperatureImage: NSTextAttachment = {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "Frame-2")
        imageAttachment.bounds = CGRect(x: 0, y: -4, width: 25, height: 33)
        return imageAttachment
    }()
    
    let gradusIcon: NSTextAttachment = {
        let secondImageAttachment = NSTextAttachment()
        secondImageAttachment.image = UIImage(systemName: "circle")
        secondImageAttachment.bounds = CGRect(x: 0, y: 20, width: 4, height: 4)
        return secondImageAttachment
    }()
    
    lazy var centralTemperature: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 37))
        label.textColor = .black
        label.font = UIFont(name: "Rubik-Regular", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    let weatherStateText: UILabel = {
        let view = UILabel()
        view.text = "Ливни"
        view.textColor = .black
        view.font = UIFont(name: "Rubik-Medium", size: 18)
        view.numberOfLines = 1
        view.textAlignment = .center
        return view
    }()
    
    func setConstraints() {
        
        header.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(21)
            make.leading.equalTo(self.snp.leading).offset(15)
        }
        
        centralTemperature.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        weatherStateText.snp.makeConstraints { make in
            make.top.equalTo(centralTemperature.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews(header, centralTemperature, weatherStateText)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
