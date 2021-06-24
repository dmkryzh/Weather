//
//  DailyForecastViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 24.06.2021.
//

import Foundation
import UIKit

enum WeatherIcons {

    case wind
    case cloud
    case temperature
    case ultravioletLevel
    case rain
    
    func getIcon() -> UIImage {
        switch self {
        case .cloud:
            return UIImage(named: "Frame-3") ?? UIImage()
        case .wind:
            return UIImage(named: "wind-1") ?? UIImage()
        case .temperature:
            return UIImage(named: "Frame-6") ?? UIImage()
        case .ultravioletLevel:
            return UIImage(named: "Frame") ?? UIImage()
        case .rain:
            return UIImage(named: "Frame-2") ?? UIImage()
        }
    }
}

class DailyForecastViewModel {
    
    

}
