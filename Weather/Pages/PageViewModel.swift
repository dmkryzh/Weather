//
//  PageViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation
import RealmSwift


class PageViewModel {
    
    var cityName: String?
    
    var data: DataFromNetwork
    
    let currentDate = Date()
    
    var pageIndex: Int
    
    var selectedCell = [IndexPath]()
    
    var date: Date?
    
    var rain: Int?
    
    var title: String?
    
    var tempMin: Double?
    
    var tempMax: Double?
    
    func getDailyForecast(_ dayNumber: Int) {
        guard let cityName = self.cityName else { return }
        data.getWeatherForecast(cityName, .daily) {
            let dailyForecast: Results<WeatherForecast> = self.data.getData("index = \(dayNumber)")
            self.date = dailyForecast[0].dt
            self.title = dailyForecast[0].weatherDescription
            self.tempMin = dailyForecast[0].tempMin
            self.tempMax = dailyForecast[0].tempMax
        }
    }
    
    init(index: Int, city: String? = nil, data: DataFromNetwork) {
        pageIndex = index
        self.data = data
        self.cityName = city
        self.getDailyForecast(7)
    }
}
