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
    
    var icons: [String]?
    
    var title: String?
    
    var tempMin: Double?
    
    var tempMax: Double?
    
    var currentTemp: Double?
    
    var currentTempArray: [Double]?
    
    var sundawn: Date?
    
    var sunset: Date?
    
    var data: DataFromNetwork?
    
    var arrayOfHourlyForecast: [Double]?
    
    var timeline: [String]?
    
    var wind: [Double]?
    
    var clouds: [Int]?
    
    var forecastValues: Results<WeatherForecast>? {
        didSet {
            addTemperatureChart()
            guard let _ = forecastValues else { return }
            guard let updateData = updateData else { return }
            updateData()
        }
    }
    
    func addTemperatureChart() {
        
        var temporaryTemp = [Double]()
        var temporaryTime = [String]()
        var temporaryIcon = [String]()
        var temporaryWind = [Double]()
        var temporaryCloud = [Int]()
        
        forecastValues?.forEach { element in
            if element.index < 24 {
                temporaryTemp.append(element.temp)
                temporaryTime.append("\(element.dt.getFormattedDate(format: "HH:00"))")
                temporaryIcon.append(element.weatherIcon)
                temporaryWind.append(element.windSpeed)
                temporaryCloud.append(element.clouds)
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

        for (index, element) in temporaryIcon.enumerated() {
            if [0,3,6,9,12,15,18,21,24].contains(index) {
                icons == nil ? icons = [element] : icons?.append(element)
            }
        }

        for (index, element) in temporaryWind.enumerated() {
            if [0,3,6,9,12,15,18,21,24].contains(index) {
                wind == nil ? wind = [element] : wind?.append(element)
            }
        }

        for (index, element) in temporaryCloud.enumerated() {
            if [0,3,6,9,12,15,18,21,24].contains(index) {
                clouds == nil ? clouds = [element] : clouds?.append(element)
            }
        }
    }
    
    func getHourlyForecast(_ city: String) {
        forecastValues = DataFromNetwork.shared.getData("city = '\(city)' AND forecastType = 'hourly'")
    }
    
    init(city: String? = nil) {
        guard let city = city else { return }
        cityName = city
        getHourlyForecast(city)
        
    }
}

