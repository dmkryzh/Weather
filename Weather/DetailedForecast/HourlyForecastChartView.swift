//
//  HourlyForecastChartView.swift
//  Weather
//
//  Created by Dmitrii KRY on 28.06.2021.
//

import Foundation
import UIKit
import SnapKit

class HourlyForecastChartView: UICollectionViewCell {
    
    
    
    
//    func setConstraints() {
//        self.snp.makeConstraints() { make in
//            make.edges.equalTo(self.snp.edges)
//        }
//
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
//        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
