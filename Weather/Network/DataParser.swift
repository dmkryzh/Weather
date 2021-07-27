//
//  DataParser.swift
//  Weather
//
//  Created by Dmitrii KRY on 22.07.2021.
//

import Foundation
import RealmSwift

class DataParser {
    
    static func decodeForecast(_ data: Data, _ completion: ((Forecast) -> Void)?) {
        do {
            let jsonDecoder = JSONDecoder()
            let response = try jsonDecoder.decode(Forecast.self, from: data)
            print(response)
            if let completion = completion {
                completion(response)
            }
        } catch {
            print(error)
            
        }
    }
    
    static func decodeCoordinates(_ data: Data) -> [String: String]? {
        do {
            let jsonDecoder = JSONDecoder()
            let response = try jsonDecoder.decode(Coordinates.self, from: data)
            let coordinates = response.response?.geoObjectCollection?.featureMember?.first?.geoObject?.point?.pos
            guard let point = coordinates?.components(separatedBy: " ")  else { return nil }
            guard let lon = point.first, let lat = point.last else { return nil}
            return [lat: lon]
        } catch {
            print(error)
            return nil
        }
    }
    
    static func decodeCity(_ data: Data) -> String? {
        do {
            var cityToReturn = ""
            let jsonDecoder = JSONDecoder()
            let response = try jsonDecoder.decode(Coordinates.self, from: data)
            let cityString = response.response?.geoObjectCollection?.featureMember?.first?.geoObject?.geoObjectDescription
            
            if let city = cityString?.components(separatedBy: ", "){
                cityToReturn = city.first ?? ""
            }
            return cityToReturn
            
        } catch {
            print(error)
            return nil
        }
    }
    
    static func createEntity(_ city: String, _ forecastType: String, _ forecastArray: [WeatherProtocol]) {
        
        let realm: Realm? = {
            return try? Realm()
        }()
        
        var index = 0
        
        forecastArray.forEach { element in
            let newCity = WeatherForecast()
            newCity.index = index
            index += 1
            newCity.city = city
            newCity.forecastType = forecastType
            newCity.clouds = element.clouds
            newCity.dewPoint = element.dewPoint
            
            let date = Date(timeIntervalSince1970: element.dt)
            newCity.dt = date
            
            newCity.feelsLike = element.feelsLikeTemp ?? 0
            newCity.feelsLikeDay = element.feelsLikeArray?.day ?? 0
            newCity.feelsLikeNight = element.feelsLikeArray?.night ?? 0
            newCity.feelsLikeMorn = element.feelsLikeArray?.morn ?? 0
            newCity.feelsLikeEve = element.feelsLikeArray?.eve ?? 0
            
            newCity.temp = element.currentTemp ?? 0
            newCity.tempDay = element.temperature?.day ?? 0
            newCity.tempMin = element.temperature?.min ?? 0
            newCity.tempMax = element.temperature?.max ?? 0
            newCity.tempEve = element.temperature?.eve ?? 0
            newCity.tempMorn = element.temperature?.morn ?? 0
            
            newCity.humidity = element.humidity
            newCity.pop = element.pop ?? 0
            newCity.pressure = element.pressure
            newCity.uvi = element.uvi
            
            newCity.weatherId = element.weather.first?.id ?? 0
            newCity.weatherMain = element.weather.first?.main ?? ""
            newCity.weatherIcon = element.weather.first?.icon ?? ""
            newCity.weatherDescription = element.weather.first?.weatherDescription ?? ""
            
            newCity.windDeg = element.windDeg
            newCity.windGust = element.windGust ?? 0
            newCity.windSpeed = element.windSpeed
            
            try? realm?.write() {
                realm?.add(newCity)
            }
        }
        
    }
    
}

