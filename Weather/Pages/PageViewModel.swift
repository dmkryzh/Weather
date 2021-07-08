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
    
    func getDataForCity(_ city: String, _ period: ForecastPeriod) {
        self.data.getWeatherForecast(city, period) {
            self.forecastRawValues = self.data.realm.objects(WeatherForecast.self)
        }
    }
    
    var data: DataFromNetwork
    
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
        dataDidLoad?.dataDidLoad()
        cityIsUpdated?()
    }
}
    
    func getForecast(index: Int, city: String, period: ForecastPeriod) {
        guard let forecastRawValues = forecastRawValues else { return }
        let forecastValues = forecastRawValues.filter("index = \(index) AND city = '\(city)' AND forecastType = '\(period)'")
        self.date = forecastValues[0].dt
        self.title = forecastValues[0].weatherDescription
        self.tempMin = forecastValues[0].tempMin
        self.tempMax = forecastValues[0].tempMax
        self.icon = forecastValues[0].weatherIcon
    }
    
    init(index: Int, city: String? = nil, data: DataFromNetwork) {
        pageIndex = index
        self.data = data
        guard let city = city else { return }
        if !cities.contains(city) {
            self.cityName = city
            getDataForCity(city, .daily)
            getDataForCity(city, .hourly)
            getDataForCity(city, .current)
        } else {
            getForecast(index: index, city: city, period: .daily)
            getForecast(index: index, city: city, period: .hourly)
        }
        
    }
}
