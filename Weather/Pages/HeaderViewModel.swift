//
//  HeaderViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 08.07.2021.
//


import Foundation
import RealmSwift

protocol HeaderViewUpdate {
    func dataDidLoad()
}


class HeaderViewModel {
    
    var parentViewModel: PageViewModel
    
    var dataDidLoad: HeaderViewUpdate?
    
    var cityName: String? {
        didSet {
            guard let city = parentViewModel.cityName else { return }
//            getCurrentForecast(city: city, period: .current)
        }
        
    }
    
    let currentDate = Date()
    
    var date: Date?
    
    var icon: String?
    
    var title: String?
    
    var tempMin: Double?
    
    var tempMax: Double?
    
    var currentTemp: Double?
    
    var sundawn: Date?
    
    var sunset: Date?
    
    var forecastValues: Results<WeatherForecast>? {
        didSet {
            dataDidLoad?.dataDidLoad()
        }
    }
    
    var updateData: (()->Void)?
    
//    func getCurrentForecast(city: String, period: ForecastPeriod) {
//        guard let forecastValues = self.parentViewModel.forecastRawValues?.filter("city = '\(city)' AND forecastType = '\(period)'") else { return }
//        guard let _ = forecastValues.first else { return }
//        self.date = forecastValues[0].dt
//        self.title = forecastValues[0].weatherDescription
//        self.tempMin = forecastValues[0].tempMin
//        self.tempMax = forecastValues[0].tempMax
//        self.icon = forecastValues[0].weatherIcon
//        self.currentTemp = forecastValues[0].temp
//        self.sunset = forecastValues[0].sunset
//        self.sundawn = forecastValues[0].sunrise
//
//        guard let updateData = updateData else { return }
//        updateData()
//    }
    
    
    
    init(_ parentViewModel: PageViewModel) {
        self.parentViewModel = parentViewModel
//        parentViewModel.cityIsUpdated = {
//            self.getCurrentForecast(city: parentViewModel.cityName ?? "", period: .current)
//        }
    }
        
}
