//
//  SettingsView.swift
//  Weather
//
//  Created by Dmitrii KRY on 17.06.2021.
//

import Foundation
import UIKit
import SnapKit
import TOSegmentedControl

class SettingsView: UIView {
    
    let settingsLabel: UILabel = {
        let view = UILabel()
        view.text = "Настройки"
        view.textColor = .black
        view.font = UIFont(name: "Rubik-Regular", size: 18)
        return view
    }()
    
    let temperatureLabel: UILabel = {
        let view = UILabel()
        view.text = "Температура"
        view.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let windSpeedLabel: UILabel = {
        let view = UILabel()
        view.text = "Скорость ветра"
        view.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let timeFormatLabel: UILabel = {
        let view = UILabel()
        view.text = "Формат времени"
        view.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    let notificationsLabel: UILabel = {
        let view = UILabel()
        view.text = "Уведомления"
        view.textColor = UIColor(red: 0.538, green: 0.513, blue: 0.513, alpha: 1)
        view.font = UIFont(name: "Rubik-Regular", size: 16)
        return view
    }()
    
    
    lazy var temperatureSlider: SegmentedControl = {
        let view = SegmentedControl(items: ["C", "F"])
        view.segmentTappedHandler = { segmentIndex, reversed in
           print("Segment \(segmentIndex) was tapped!")
        }
        view.cornerRadius = 5
        view.itemColor = .black
        view.selectedItemColor = .white
        view.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        view.thumbColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
        view.thumbInset = 0
        view.textFont = UIFont(name: "Rubik-Regular", size: 16)
        view.selectedTextFont = UIFont(name: "Rubik-Regular", size: 16)
        view.subviews[0].subviews.forEach { view in
            view.layer.cornerRadius = 0
        }
        return view
    }()
    
    let windSpeedSlider: SegmentedControl = {
        let view = SegmentedControl(items: ["Mi", "Km"])
        view.segmentTappedHandler = { segmentIndex, reversed in
           print("Segment \(segmentIndex) was tapped!")
        }
        view.cornerRadius = 5
        view.itemColor = .black
        view.selectedItemColor = .white
        view.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        view.thumbColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
        view.thumbInset = 0
        view.textFont = UIFont(name: "Rubik-Regular", size: 16)
        view.selectedTextFont = UIFont(name: "Rubik-Regular", size: 16)
        view.subviews[0].subviews.forEach { view in
            view.layer.cornerRadius = 0
        }
        return view
    }()
    
    let timeFormatSlider: SegmentedControl = {
        let view = SegmentedControl(items: ["12", "24"])
        view.segmentTappedHandler = { segmentIndex, reversed in
           print("Segment \(segmentIndex) was tapped!")
        }
        view.cornerRadius = 5
        view.itemColor = .black
        view.selectedItemColor = .white
        view.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        view.thumbColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
        view.thumbInset = 0
        view.textFont = UIFont(name: "Rubik-Regular", size: 16)
        view.selectedTextFont = UIFont(name: "Rubik-Regular", size: 16)
        view.subviews[0].subviews.forEach { view in
            view.layer.cornerRadius = 0
        }
        return view
    }()
    
    let notificationSlider: SegmentedControl = {
        let view = SegmentedControl(items: ["On", "Off"])
        view.segmentTappedHandler = { segmentIndex, reversed in
           print("Segment \(segmentIndex) was tapped!")
        }
        view.cornerRadius = 5
        view.itemColor = .black
        view.selectedItemColor = .white
        view.backgroundColor = UIColor(red: 0.996, green: 0.929, blue: 0.914, alpha: 1)
        view.thumbColor = UIColor(red: 0.122, green: 0.302, blue: 0.773, alpha: 1)
        view.thumbInset = 0
        view.textFont = UIFont(name: "Rubik-Regular", size: 16)
        view.selectedTextFont = UIFont(name: "Rubik-Regular", size: 16)
        view.subviews[0].subviews.forEach { view in
            view.layer.cornerRadius = 0
        }
        return view
    }()

    let setButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1)
        view.layer.cornerRadius = 10
        let color = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        let font = UIFont(name: "Rubik-Regular", size: 16)
        let title = NSAttributedString(string: "Установить", attributes: [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font as Any])
        view.setAttributedTitle(title, for: .normal)
        view.addTarget(self, action: #selector(applySettings), for: .touchUpInside)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var didTap: (() -> Void)?
    
    @objc func applySettings() { 
        guard let didTap = didTap else { return }
        didTap()
    }
    
    func setConstrains() {

        settingsLabel.snp.makeConstraints{ make in
            make.top.equalTo(self.snp.top).offset(27)
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.leading.equalTo(self.snp.leading).offset(20)
        }
        
        temperatureLabel.snp.makeConstraints{ make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(20)
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.leading.equalTo(self.snp.leading).offset(20)
        }
        
        windSpeedLabel.snp.makeConstraints{ make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(27)
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.leading.equalTo(self.snp.leading).offset(20)
        }
        
        timeFormatLabel.snp.makeConstraints{ make in
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(27)
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.leading.equalTo(self.snp.leading).offset(20)
        }
        
        notificationsLabel.snp.makeConstraints{ make in
            make.top.equalTo(timeFormatLabel.snp.bottom).offset(27)
            make.width.equalTo(140)
            make.height.equalTo(20)
            make.leading.equalTo(self.snp.leading).offset(20)
        }
        
        temperatureSlider.snp.makeConstraints{ make in
            make.top.equalTo(self.snp.top).offset(57)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.trailing.equalTo(self.snp.trailing).inset(20)
        }
        
        windSpeedSlider.snp.makeConstraints{ make in
            make.top.equalTo(temperatureSlider.snp.bottom).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.trailing.equalTo(self.snp.trailing).inset(20)
        }
        
        timeFormatSlider.snp.makeConstraints{ make in
            make.top.equalTo(windSpeedSlider.snp.bottom).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.trailing.equalTo(self.snp.trailing).inset(20)
        }
        
        notificationSlider.snp.makeConstraints{ make in
            make.top.equalTo(timeFormatSlider.snp.bottom).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.trailing.equalTo(self.snp.trailing).inset(20)
        }
        
        setButton.snp.makeConstraints{ make in
            make.top.equalTo(notificationsLabel.snp.bottom).offset(42)
            make.width.equalTo(250)
            make.height.equalTo(40)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(settingsLabel, temperatureLabel, temperatureSlider, windSpeedLabel, windSpeedSlider, timeFormatLabel, timeFormatSlider, notificationsLabel, notificationSlider, setButton)
        backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        setConstrains()
        layer.cornerRadius = 10
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
