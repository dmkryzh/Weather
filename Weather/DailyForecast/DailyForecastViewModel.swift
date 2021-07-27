//
//  DailyForecastViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 24.06.2021.
//

import Foundation
import UIKit
import RealmSwift

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
            self.date = forecastValues.first?.dt
            self.title = forecastValues.first?.weatherDescription
            self.wind = forecastValues.first?.windSpeed
            self.rain = forecastValues.first?.rain
            self.clouds = forecastValues.first?.clouds
            self.icon = forecastValues.first?.weatherIcon
            self.tempFeelsLike = forecastValues.first?.feelsLike
            self.uvi = forecastValues.first?.uvi
            self.temperature = forecastValues.first?.temp
            self.temperatureDay = forecastValues.first?.tempDay
            self.temperatureNight = forecastValues.first?.tempNight
            self.tempFeelsLikeDay = forecastValues.first?.feelsLikeDay
            self.tempFeelsLikeNight = forecastValues.first?.feelsLikeNight
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
