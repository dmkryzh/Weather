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
    
    var forecastsCount: Int?
    
    var cityName: String?
    
    func get(_ city: String) {
        self.data.getWeatherForecast(city, .daily) {
                        self.dailyForecast = self.data.realm.objects(WeatherForecast.self)
                        self.forecastsCount = self.dailyForecast?.count
                    }
    }
    
    var data: DataFromNetwork
    
    let currentDate = Date()
    
    var pageIndex: Int
    
    var selectedCell = [IndexPath]()
    
    var date: Date?
    
    var rain: Int?
    
    var title: String?
    
    var tempMin: Double?
    
    var tempMax: Double?
    
    var dailyForecast: Results<WeatherForecast>? {
        didSet {
            dataDidLoad?.dataDidLoad()
        }
    }
    
    func getDailyForecast(index: Int) {
        guard let dailyForecast = self.dailyForecast?.filter("index = \(index)") else { return }
        self.date = dailyForecast[0].dt
        self.title = dailyForecast[0].weatherDescription
        self.tempMin = dailyForecast[0].tempMin
        self.tempMax = dailyForecast[0].tempMax
    }
    
    init(index: Int, city: String? = nil, data: DataFromNetwork) {
        pageIndex = index
        self.data = data
        guard let city = city else { return }
        self.cityName = city
        get(city)
    }
}
