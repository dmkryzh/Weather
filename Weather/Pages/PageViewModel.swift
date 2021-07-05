//
//  PageViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 09.06.2021.
//

import Foundation
import RealmSwift


class PageViewModel {
    
    var dataDidLoad: (() -> Void)?
    
    var dayIndex: Int? {
        didSet {
            guard let city = cityName else { return }
            data.getWeatherForecast(city, .daily) { [weak self] in
                guard let self = self else { return }
                guard let index = self.dayIndex else { return }
                self.dailyForecast = self.data.realm.objects(WeatherForecast.self)
                self.getDailyForecast(index: index)
            }
        }
    }
    
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
    
    var dailyForecast: Results<WeatherForecast>?
    
    func getDailyForecast(index: Int) {
        guard let dailyForecast = self.dailyForecast?.filter("index = \(index)") else { return }
        self.date = dailyForecast[0].dt
        self.title = dailyForecast[0].weatherDescription
        self.tempMin = dailyForecast[0].tempMin
        self.tempMax = dailyForecast[0].tempMax
        guard let updateData = self.dataDidLoad else { return }
        updateData()
    }
    
    init(index: Int, city: String? = nil, dayIndex: Int? = nil, data: DataFromNetwork) {
        pageIndex = index
        self.data = data
        self.cityName = city
        self.dayIndex = dayIndex
    }
}
