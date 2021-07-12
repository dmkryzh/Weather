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
    
   private lazy var statusCircle: NSAttributedString = {
        let secondImageAttachment = NSTextAttachment()
        secondImageAttachment.image = UIImage(systemName: "circle")
        secondImageAttachment.bounds = CGRect(x: 0, y: 12, width: 3, height: 3)
        let secondAttachmentString = NSAttributedString(attachment: secondImageAttachment)
        return secondAttachmentString
    }()
    
    private var status: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        view.textAlignment = .right
        return view
    }()
    
    private var leftLabelImage: NSTextAttachment = {
        let imageAttachment = NSTextAttachment()
        return imageAttachment
    }()
    
    private var leftLabelText: NSAttributedString = {
        let string = NSAttributedString()
        return string
    }()
    
    func iconTextAndBounds(icon: UIImage, iconText: String, statusText: String, isWithCircle: Bool = false, bounds: CGRect) {
        leftLabelImage.image = icon
        leftLabelImage.bounds = bounds
        leftLabelText = NSAttributedString(string: iconText)
        leftLabel.attributedText = completeText
        status.text = statusText
        if isWithCircle {
            let text = NSMutableAttributedString(string: statusText)
            text.append(statusCircle)
            status.attributedText = text
        }
        
    }
    
    private lazy var completeText: NSMutableAttributedString = {
        let attachmentString = NSAttributedString(attachment: leftLabelImage)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        completeText.append(leftLabelText)
        return completeText
    }()
    
    private lazy var leftLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Rubik-Regular", size: 14)
        view.textAlignment = .left
        return view
    }()
    
    private func setConstraints() {
        
        leftLabel.snp.makeConstraints { make in
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
        addSubviews(status, leftLabel)
        setConstraints()
        backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
