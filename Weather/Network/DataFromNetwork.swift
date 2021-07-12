//
//  DataFromNetwork.swift
//  Weather
//
//  Created by Dmitrii KRY on 01.07.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

enum ForecastPeriod: String {
    case current = "current"
    case hourly = "hourly"
    case daily = "daily"
}

enum MeasurementUnits: String {
    case metric = "metric"
    case imperial = "imperial"
}

class DataFromNetwork {
    
    static let shared = DataFromNetwork()
    
    private(set) var city = ""
    
    private let config = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        })
    
    lazy var realm: Realm? = {
        return try? Realm(configuration: config)
    }()
    
    
    
    private lazy var parametersForCoordinates: [String: Any] = [
        "apikey": "63f2307a-7e04-4070-a049-6ba223752433",
        "format": "json",
        "geocode": ""
    ]
    
    private var headersForForecast: HTTPHeaders = [
        "User-Agent": "WeatherForecast 0.2 https://github.com/dmkryzh/Weather"
    ]
    
    private var parametersForGetForecast: [String: Any] = [
        "lat": "",
        "lon": "",
        "appid": "c1ec333963b5e6cb184dd81488128a84",
        "exclude": "minutely,alerts",
        "units": "metric",
        "lang": "ru"
    ]
    
    var dataDidLoad: (()->Void)?
    
    func updateParamsForForecast(_ lat: String = "", _ lon: String = "", _ units: String = MeasurementUnits.metric.rawValue) {
        parametersForGetForecast["lat"] = lat
        parametersForGetForecast["lon"] = lon
        parametersForGetForecast["units"] = units
    }
    
    
    func getWeatherForecast(_ city: String, completion: (()->Void)? = nil) {
        self.city = city
        parametersForCoordinates["geocode"] = city
        AF.request("https://geocode-maps.yandex.ru/1.x/", method: .get, parameters: parametersForCoordinates).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let pos = json["response"]["GeoObjectCollection"]["featureMember"].arrayValue.map {
                    $0["GeoObject"]["Point"]["pos"].stringValue
                }
                if let point = pos.first?.components(separatedBy: " ") {
                    self.updateParamsForForecast(point.last ?? "", point.first ?? "")
                }
                
                self.getDataForForecast(self.parametersForGetForecast, completion: completion)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func createEntity(forecastArray: [JSON], forecastType: String) {
        var index = 0
        for day in forecastArray {
            let newCity = WeatherForecast()
            
            newCity.index = index
            index += 1
            newCity.city = self.city
            newCity.forecastType = forecastType
            newCity.clouds = day["clouds"].intValue
            newCity.dewPoint = day["dew_point"].doubleValue
            
            let date = Date(timeIntervalSince1970: day["dt"].doubleValue)
            newCity.dt = date
            
            newCity.feelsLikeDay = day["feels_like"]["day"].doubleValue
            newCity.feelsLikeEve = day["feels_like"]["eve"].doubleValue
            newCity.feelsLikeMorn = day["feels_like"]["morn"].doubleValue
            newCity.feelsLikeNight = day["feels_like"]["night"].doubleValue
            
            newCity.humidity = day["humidity"].intValue
            newCity.moonPhase = day["moon_phase"].doubleValue
            newCity.moonrise = Date(timeIntervalSince1970: day["moonrise"].doubleValue)
            newCity.moonset = Date(timeIntervalSince1970: day["moonset"].doubleValue)
            newCity.pop = day["pop"].intValue
            newCity.pressure = day["pressure"].intValue
            newCity.sunrise = Date(timeIntervalSince1970: day["sunrise"].doubleValue)
            newCity.sunset = Date(timeIntervalSince1970: day["sunset"].doubleValue)
            
            newCity.temp = day["temp"].doubleValue
            
            newCity.tempDay = day["temp"]["day"].doubleValue
            newCity.tempEve = day["temp"]["eve"].doubleValue
            newCity.tempMax = day["temp"]["max"].doubleValue
            newCity.tempMin = day["temp"]["min"].doubleValue
            newCity.tempMorn = day["temp"]["morn"].doubleValue
            newCity.tempNight = day["temp"]["night"].doubleValue
            
            newCity.uvi = day["uvi"].doubleValue
            
            newCity.weatherId = day["weather"].arrayValue.map {$0["id"].intValue }.first ?? 0
            newCity.weatherMain = day["weather"].arrayValue.map {$0["main"].stringValue }.first ?? ""
            newCity.weatherIcon = day["weather"].arrayValue.map {$0["icon"].stringValue }.first ?? ""
            newCity.weatherDescription = day["weather"].arrayValue.map {$0["description"].stringValue }.first ?? ""
            
            newCity.windDeg = day["wind_deg"].doubleValue
            newCity.windGust = day["wind_gust"].doubleValue
            newCity.windSpeed = day["wind_speed"].doubleValue
            
            try? self.realm?.write() {
                self.realm?.add(newCity)
            }
            
        }
        
    }
    
    
    private func getDataForForecast(_ params: [String: Any], completion: (()->Void)? = nil) {
        
        AF.request("https://api.openweathermap.org/data/2.5/onecall", method: .get, parameters: params, headers: headersForForecast).responseJSON { response in
            
            switch response.result {
            
            case .success(let object):
                
                let json = JSON(object)
                var forecastArray = [JSON]()
                var forecastType = ""
                
                for (key, value) in json.dictionary! {
                    
                    if key == "current" {
                        forecastArray = [value]
                        forecastType = "current"
                        self.createEntity(forecastArray: forecastArray, forecastType: forecastType)
                    } else if key == "daily" {
                        forecastArray = value.arrayValue
                        forecastType = "daily"
                        self.createEntity(forecastArray: forecastArray, forecastType: forecastType)
                    } else if key == "hourly" {
                        forecastArray = value.arrayValue
                        forecastType = "hourly"
                        self.createEntity(forecastArray: forecastArray, forecastType: forecastType)
                    }
                }
                
                guard let completion = completion else { return }
                completion()
                
                guard let dataDidLoad = self.dataDidLoad else { return }
                dataDidLoad()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getData(_ textFilter: String? = nil) -> Results<WeatherForecast>? {
        if let text = textFilter {
            let object = realm?.objects(WeatherForecast.self).filter(text)
            return object
        } else {
            let object = realm?.objects(WeatherForecast.self)
            return object
        }
    }
    
    private init() { }
    
}
