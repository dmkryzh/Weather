//
//  HeaderViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 08.07.2021.
//


import Foundation
import RealmSwift

class HeaderViewModel {
    
    var parentViewModel: PageViewModel
    
    var cityName: String? 
    
    let currentDate = Date()
    
    var date: Date?
    
    var icon: String?
    
    var title: String?
    
    var tempMin: Double?
    
    var tempMax: Double?
    
    var currentTemp: Double?
    
    var sundawn: Date?
    
    var sunset: Date?
    
    func getCurrentForecast(city: String, forecastType: ForecastPeriod, completion: (()->Void)? = nil) {
        parentViewModel.rawForecastIsLoaded = {
            
            guard let forecastValues = DataFromNetwork.shared.getData("city = '\(city)' AND forecastType = '\(forecastType.rawValue)'") else { return }
            
            guard let _ = forecastValues.first else { return }
            self.date = forecastValues[0].dt
            self.title = forecastValues[0].weatherDescription
            self.tempMin = forecastValues[0].tempMin
            self.tempMax = forecastValues[0].tempMax
            self.icon = forecastValues[0].weatherIcon
            self.currentTemp = forecastValues[0].temp
            self.sunset = forecastValues[0].sunset
            self.sundawn = forecastValues[0].sunrise
            
            guard let completion = completion else { return }
            completion()
            
        }
    }
    
    init(_ parentViewModel: PageViewModel) {
        self.parentViewModel = parentViewModel
        
    }
    
}
