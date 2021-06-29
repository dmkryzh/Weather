//
//  AirQualityView.swift
//  Weather
//
//  Created by Dmitrii KRY on 27.06.2021.
//

import Foundation
import UIKit
import SnapKit

class AirQualityView: UIView {
    
    enum StatusQuality {
        
        case good
        case medium
        case bad
        
        func getStatusColor() -> UIColor {
            switch self {
            case .good:
                return UIColor(red: 0.507, green: 0.792, blue: 0.501, alpha: 1)
            case .medium:
                return UIColor(red: 0.507, green: 0.792, blue: 0.501, alpha: 1)
            case .bad:
                return UIColor(red: 0.507, green: 0.792, blue: 0.501, alpha: 1)
            }
        }
        
        func getStatusText() -> String {
            switch self {
            case .good:
                return "Хорошо"
            case .medium:
                return "Средне"
            case .bad:
                return "Плохо"
            }
        }
    }
    
    
    let titleQuality: UILabel = {
        let view = UILabel()
        view.text = "Качество воздуха"
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        view.textColor = .black
        return view
    }()
    
    
    let digitQuality: UILabel = {
        let view = UILabel()
        view.text = "42"
        view.font = UIFont(name: "Rubik-Regular", size: 30)
        view.textColor = .black
        return view
    }()
    
    
    let statusQuality: UILabel = {
        let view = UILabel()
        view.text = "хорошо"
        view.textAlignment = .center
        view.textColor = .white
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        view.backgroundColor = UIColor(red: 0.507, green: 0.792, blue: 0.501, alpha: 1)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    let textQuality: UILabel = {
        let view = UILabel()
        view.text = "Качество воздуха считается удовлетворительным и загрязнения воздуха представляются незначительными в пределах нормы"
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        view.numberOfLines = 0
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        return view
    }()
    
    func setConstraints() {
        titleQuality.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.height.equalTo(22)
            make.width.equalTo(160)
        }
        
        digitQuality.snp.makeConstraints { make in
            make.top.equalTo(titleQuality.snp.bottom).offset(10)
            make.leading.equalTo(self.snp.leading)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        statusQuality.snp.makeConstraints { make in
            make.centerY.equalTo(digitQuality.snp.centerY)
            make.leading.equalTo(digitQuality.snp.trailing).offset(5)
            make.height.equalTo(26)
            make.width.equalTo(95)
            
        }
        
        textQuality.snp.makeConstraints { make in
            make.top.equalTo(digitQuality.snp.bottom).offset(10)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(76)
            make.width.equalTo(344)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(titleQuality, digitQuality, statusQuality, textQuality)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
