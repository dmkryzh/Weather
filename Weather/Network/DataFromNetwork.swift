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
    case mixed = "mixed"
    case hourly = "hourly"
    case daily = "daily"
}

class DataFromNetwork {
    
    private(set) var city = ""
    private(set) var period = ""
    private(set) var lon = ""
    private(set) var lat = ""
    
    private let config = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        })
    
    lazy var realm: Realm = {
        try? FileManager().removeItem(at: config.fileURL!)
        return try! Realm(configuration: config)
    }()
    
    
    
    private lazy var parametersForCoordinates: [String: Any] = [
        "apikey": "63f2307a-7e04-4070-a049-6ba223752433",
        "format": "json",
        "geocode": ""
    ]
    
    private var headersForForecast: HTTPHeaders = [
        "User-Agent": "WeatherForecast 0.2 https://github.com/dmkryzh/Weather"
    ]
    
    private var cityPoint: [String: Any] = [
        "lat": "37.622513",
        "lon": "55.75322",
        "appid": "c1ec333963b5e6cb184dd81488128a84",
        "exclude": "current,minutely,alerts",
        "units": "metric",
        "lang": "ru"
    ]
    
    private var parametersForGetForecast: [String: Any] = [
        "lat": "",
        "lon": "",
        "appid": "c1ec333963b5e6cb184dd81488128a84",
        "exclude": "current,minutely,alerts",
        "units": "metric",
        "lang": "ru"
    ]
    
    func getWeatherForecast(_ city: String, _ period: ForecastPeriod, completion: (()->Void)? = nil) {
        self.city = city
        parametersForCoordinates["geocode"] = city
        AF.request("https://geocode-maps.yandex.ru/1.x/", method: .get, parameters: parametersForCoordinates).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let pos = json["response"]["GeoObjectCollection"]["featureMember"].arrayValue.map {
                    $0["GeoObject"]["Point"]["pos"].string!
                }
                if let point = pos.first?.components(separatedBy: " ") {
                    self.parametersForGetForecast["lon"] = point.first
                    self.parametersForGetForecast["lat"] = point.last
                    self.lon = point.first ?? ""
                    self.lat = point.last ?? ""
                }
                
                self.getDataForForecast(self.parametersForGetForecast, period, completion: completion)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    private func getDataForForecast(_ params: [String: Any], _ period: ForecastPeriod, completion: (()->Void)? = nil) {
        
        AF.request("https://api.openweathermap.org/data/2.5/onecall", method: .get, parameters: params, headers: headersForForecast).responseJSON { response in
            
            switch response.result {
            
            case .success(let value):
                
                let json = JSON(value)
                var forecastArray = [JSON]()
                var index = 0
                
                switch period {
                case .mixed:
                    forecastArray = json["hourly"].arrayValue + json["daily"].arrayValue
                case .daily:
                    forecastArray = json["daily"].arrayValue
                case .hourly:
                    forecastArray = json["hourly"].arrayValue
                }

                for day in forecastArray {
                    let newCity = WeatherForecast()
                    
                    newCity.index = index
                    index += 1
                    newCity.city = self.city
                    newCity.forecastType = period.rawValue
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
                    newCity.moonrise = day["moonrise"].intValue
                    newCity.moonset = day["moonset"].intValue
                    newCity.pop = day["pop"].intValue
                    newCity.pressure = day["pressure"].intValue
                    newCity.sunrise = day["sunrise"].intValue
                    newCity.sunset = day["sunset"].intValue
                    
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
                
                    try! self.realm.write() {
                        self.realm.add(newCity)
                    }
                }
                guard let completion = completion else { return }
                completion()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testGet() {
        let object = realm.objects(WeatherForecast.self).filter("forecastType = 'daily'")
        print(object)
    }
    
    func getData(_ predicate: String) -> Results<WeatherForecast> {
        let object = realm.objects(WeatherForecast.self).filter(predicate)
        return object
    }
    
}
