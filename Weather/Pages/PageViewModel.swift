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
    
    var cityIsUpdated: (()->Void)?
    
    var cities = [String]()
    
    var cityName: String? 
    
//    func getDataForCity(_ city: String, _ period: ForecastPeriod) {
//        self.data.getWeatherForecast(city, period) {
//            self.forecastRawValues = self.data.realm?.objects(WeatherForecast.self)
//        }
//    }
    
    
    let currentDate = Date()
    
    var pageIndex: Int
    
    var selectedCell = [IndexPath]()
    
    var date: Date?
    
    var icon: String?
    
    var title: String?
    
    var tempMin: Double?
    
    var tempMax: Double?

    var forecastRawValues: Results<WeatherForecast>? {
    didSet {
      
    }
}
    
    func getForecast(index: Int, city: String, period: ForecastPeriod) {
        guard let forecastValues = DataFromNetwork.shared.getData("index = \(index) AND city = '\(city)' AND forecastType = '\(period)'") else { return }
//        self.date = forecastValues[0].dt
//        self.title = forecastValues[0].weatherDescription
//        self.tempMin = forecastValues[0].tempMin
//        self.tempMax = forecastValues[0].tempMax
//        self.icon = forecastValues[0].weatherIcon
    }
    
    func initialDataReuest(_ city: String) {
//    DataFromNetwork.shared.getWeatherForecast(city, .daily)
//    DataFromNetwork.shared.getWeatherForecast(city, .current)
        DataFromNetwork.shared.getWeatherForecast(city, .hourly) { [self] in
            guard let updated = cityIsUpdated else { return }
            updated()
        }
    }
    
    init(index: Int, city: String? = nil) {
        pageIndex = index
        guard let city = city else { return }
        initialDataReuest(city)
        
        if !cities.contains(city) {
            self.cityName = city
          
        } else {
            getForecast(index: index, city: city, period: .daily)
           
        }
        
    }
}
