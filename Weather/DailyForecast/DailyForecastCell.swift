//
//  DailyForecastCell.swift
//  Weather
//
//  Created by Dmitrii KRY on 24.06.2021.
//

import Foundation
import UIKit
import SnapKit

class DailyForecastCell: UITableViewCell {
    
    private let status: UILabel = {
        let view = UILabel()
        view.text = "5 m\\s ЗЮЗ"
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        view.textAlignment = .left
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
    
    func setConstraints() {
        
        windLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(15)
        }
        
        status.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing).inset(15)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews(status, windLabel)
        setConstraints()
        backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
