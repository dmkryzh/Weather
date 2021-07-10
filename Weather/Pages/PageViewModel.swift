//
//  PageViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation
import RealmSwift

protocol PageViewUpdate {
    func dataDidLoad()
}

class PageViewModel {
    
    var dataDidLoad: PageViewUpdate?
    
    var rawForecastIsLoaded: (()->Void)?
    
    var cities = [String]()
    
    var cityName: String? 
 
    let currentDate = Date()
    
    var pageIndex: Int
    
    var selectedCell = [IndexPath]()
    
    var date: Date?
    
    var icon: String?
    
    var title: String?
    
    var tempMin: Double?
    
    var tempMax: Double?
    
    var forecast: Results<WeatherForecast>? {
        didSet {
            guard let forecastValues = forecast else { return }
            self.date = forecastValues[0].dt
            self.title = forecastValues[0].weatherDescription
            self.tempMin = forecastValues[0].tempMin
            self.tempMax = forecastValues[0].tempMax
            self.icon = forecastValues[0].weatherIcon
        }
    }
    
    var forecastRawValues: Results<WeatherForecast>? {
        didSet {
            dataDidLoad?.dataDidLoad()
            guard let rawForecastIsLoaded = rawForecastIsLoaded else { return }
            rawForecastIsLoaded()
        }
    }
    
    func getForecast(index: Int, city: String, forecatType: ForecastPeriod) {
        guard let _ = forecastRawValues else { return }
        forecast = DataFromNetwork.shared.getData("index = \(index) AND city = '\(city)' AND forecastType = '\(forecatType.rawValue)'")
    }
  
    
    init(index: Int, city: String? = nil) {
        cityName = city
        pageIndex = index
        guard let city = city else { return }
        DataFromNetwork.shared.getWeatherForecast(city) {
            self.forecastRawValues = DataFromNetwork.shared.getData()
        }
    }
}
