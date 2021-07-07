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
    
    var cities = [String]()
    
    var forecastsCount: Int?
    
    var cityName: String?
    
    func getDataForCity(_ city: String) {
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
    
    func getDailyForecast(index: Int, city: String) {
        guard let dailyForecast = self.dailyForecast?.filter("index = \(index) AND city = '\(city)'") else { return }
        self.date = dailyForecast[0].dt
        self.title = dailyForecast[0].weatherDescription
        self.tempMin = dailyForecast[0].tempMin
        self.tempMax = dailyForecast[0].tempMax
        print(dailyForecast)
    }
    
    init(index: Int, city: String? = nil, data: DataFromNetwork) {
        pageIndex = index
        self.data = data
        guard let city = city else { return }
        if !cities.contains(city) {
            self.cityName = city
            getDataForCity(city)
        } else {
            getDailyForecast(index: index, city: city)
        }
        
    }
}
