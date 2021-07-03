//
//  NetworkService.swift
//  Weather
//
//  Created by Dmitrii KRY on 01.07.2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkService {
    
    let config = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
            }
        })
    
    lazy var realm: Realm = {
        try? FileManager().removeItem(at: config.fileURL!)
        return try! Realm(configuration: config)
    }()
    
    var city = "Москва"
    
    lazy var parametersForCoordinates: [String: Any] = [
        "apikey": "63f2307a-7e04-4070-a049-6ba223752433",
        "format": "json",
        "geocode": city
    ]
    
    var headersForForecast: HTTPHeaders = [
        "User-Agent": "WeatherForecast 0.2 https://github.com/dmkryzh/Weather"
    ]
    
    var cityPoint: [String: Any] = [
        "lat": "37.622513",
        "lon": "55.75322",
        "appid": "c1ec333963b5e6cb184dd81488128a84",
        "exclude": "current,minutely,hourly,alerts",
        "units": "metric",
        "lang": "ru"
    ]
    
    func getCityPoint(_ city: String = "Москва") {
        self.city = city
        AF.request("https://geocode-maps.yandex.ru/1.x/", method: .get, parameters: parametersForCoordinates).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let pos = json["response"]["GeoObjectCollection"]["featureMember"].arrayValue.map {
                    $0["GeoObject"]["Point"]["pos"].string!
                }
                let x = pos.first!.components(separatedBy: " ")
                self.cityPoint["lon"] = x.first!
                self.cityPoint["lat"] = x.last!
                
                debugPrint(self.cityPoint)
                self.getWeatherForecast(city)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getWeatherForecast(_ city: String) {
        AF.request("https://api.openweathermap.org/data/2.5/onecall", method: .get, parameters: cityPoint, headers: headersForForecast).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                try! self.realm.write() {
                    for day in json["daily"].arrayValue {
                        let newCity = WeatherForecast()
                        
                        newCity.city = city
                        newCity.forecastType = "daily"
                        newCity.clouds = day["clouds"].intValue
                        newCity.dewPoint = day["dew_point"].doubleValue
                        newCity.dt = day["dt"].intValue
                        
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
                        
                        self.realm.add(newCity)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testGet() {
        let object = realm.objects(WeatherForecast.self)
        print(object)
    }
    
}
