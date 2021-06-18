//
//  SettingsView.swift
//  Weather
//
//  Created by Dmitrii KRY on 17.06.2021.
//

import Foundation
import UIKit
import SnapKit

class SettingsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.snp.makeConstraints { make in
            make.width.equalTo(320)
            make.height.equalTo(330)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
