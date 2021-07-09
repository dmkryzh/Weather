//
//  DetailedForecastViewModel.swift
//  Weather
//
//  Created by Dmitrii KRY on 08.07.2021.
//

import Foundation
import RealmSwift

protocol DetailedForecastViewModelUpdate {
    func dataDidLoad()
}


class DetailedForecastViewModel {
    
    var dataDidLoad: DetailedForecastViewModelUpdate?
    
    var parentViewModel: PageViewModel?
    
    var updateData: (() -> Void)?
    
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
    
    var data: DataFromNetwork?
    
    var arrayOfHourlyForecast: [Double]?
    
    var timeline: [String]?
    
    func test() {
        
        var temporaryTemp = [Double]()
        var temporaryTime = [String]()
        
        forecastValues?.forEach { element in
            if element.index < 24 {
                temporaryTemp.append(element.temp)
                temporaryTime.append("\(element.dt.getFormattedDate(format: "HH:00"))")
            }
        }
        
        for (index, element) in temporaryTemp.enumerated() {
            if [0,3,6,9,12,15,18,21,24].contains(index) {
                arrayOfHourlyForecast == nil ? arrayOfHourlyForecast = [element] : arrayOfHourlyForecast?.append(element)
                
            }
        }
        
        for (index, element) in temporaryTime.enumerated() {
            if [0,3,6,9,12,15,18,21,24].contains(index) {
                timeline == nil ? timeline = [element] : timeline?.append(element)
            }
        }
        
        print(arrayOfHourlyForecast)
        print(timeline)
        
//        dataDidLoad?.dataDidLoad()
//
//        guard let update = updateData else { return }
//        update()
    }
    
    var forecastValues: Results<WeatherForecast>?
    
    
    init(city: String, data: DataFromNetwork) {
        self.data = data
        self.forecastValues = data.realm.objects(WeatherForecast.self).filter("city = '\(city)' AND forecastType = 'hourly'")
        test()
        
        
//        data.getWeatherForecast(city, .hourly) {
//            self.forecastValues = data.realm.objects(WeatherForecast.self).filter("city = '\(city)' AND forecastType = 'hourly'")
//        }
    }
        
}
