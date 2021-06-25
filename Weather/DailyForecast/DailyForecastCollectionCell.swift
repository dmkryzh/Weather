//
//  DailyForecastCollectionCell.swift
//  Weather
//
//  Created by Dmitrii KRY on 25.06.2021.
//

import Foundation
import UIKit
import SnapKit

class DailyForecastCollectionCell: UICollectionViewCell {
    let date: UILabel = {
        let date = Date()
        let formate = date.getFormattedDate(format: "d/MM EE")
        let label = UILabel()
        label.text = formate
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        return label
    }()
    
    func setConstrains() {
        date.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(22)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(date)
        self.layer.cornerRadius = 5
        backgroundColor = .white
//            UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        setConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
