//
//  DailyForecastViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 24.06.2021.
//

import Foundation
import UIKit
import RealmSwift

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

protocol DailyForecastViewModelUpdate {
    func dataDidLoad()
}

class DailyForecastViewModel {
    
    var selectedCell = [Int]()
    
    var index: Int?
    
    var dataDidLoad: DailyForecastViewModelUpdate?
    
    var dataIsLoaded: (()->Void)?
    
    var cityName: String?
    
    let currentDate = Date()
    
    var date: Date?
    
    var datesArray = [String]()
    
    var icon: String?
    
    var title: String?
    
    var temperatureDay: Double?
    
    var temperatureNight: Double?
    
    var temperature: Double?
    
    var wind: Double?
    
    var uvi: Double?
    
    var rain: Double?
    
    var clouds: Int?
    
    var tempFeelsLike: Double?
    
    var tempFeelsLikeDay: Double?
    
    var tempFeelsLikeNight: Double?
    
    var forecast: Results<WeatherForecast>? {
        didSet {
            guard let forecastValues = forecast else { return }
            self.date = forecastValues[0].dt
            self.title = forecastValues[0].weatherDescription
            self.wind = forecastValues[0].windSpeed
            self.rain = forecastValues[0].rain
            self.clouds = forecastValues[0].clouds
            self.icon = forecastValues[0].weatherIcon
            self.tempFeelsLike = forecastValues[0].feelsLike
            self.uvi = forecastValues[0].uvi
            self.temperature = forecastValues[0].temp
            self.temperatureDay = forecastValues[0].tempDay
            self.temperatureNight = forecastValues[0].tempNight
            self.tempFeelsLikeDay = forecastValues[0].feelsLikeDay
            self.tempFeelsLikeNight = forecastValues[0].feelsLikeNight
        }
    }
    
    func getForecast(index: Int?, city: String?) {
        guard let index = index, let city = city else { return }
        forecast = DataFromNetwork.shared.getData("index = \(index) AND city = '\(city)' AND forecastType = 'daily'")
    }
    
   private func getDates(_ city: String) {
        DataFromNetwork.shared.getData("city = '\(city)' AND forecastType = 'daily'")!.forEach { element in
            datesArray.append(element.dt.getFormattedDate(format: "d/MM EE"))
        }
    }
    
    init(index: Int, city: String) {
        self.index = index
        self.cityName = city
        getDates(city)
        getForecast(index: index, city: city)
    }
}
