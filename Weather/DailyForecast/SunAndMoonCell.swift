//
//  SunAndMoonCell.swift
//  Weather
//
//  Created by Dmitrii KRY on 26.06.2021.
//

import Foundation
import UIKit
import SnapKit

class SunAndMoonCell: UITableViewCell {
    
    lazy var image: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    
    lazy var leftLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        view.text = ""
        return view
    }()
    
    lazy var rightLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.textAlignment = .right
        return view
    }()
    
    func setConstraints() {
        
        image.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(18)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(15)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(20)
            make.width.equalTo(90)
            
        }
    }
    
    func updateCell(image: UIImage? = nil, leftText: String? = nil, rightText: String) {
        
        self.image.image = image
        
        self.leftLabel.text = leftText
        
        self.rightLabel.text = rightText
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(image, leftLabel, rightLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
