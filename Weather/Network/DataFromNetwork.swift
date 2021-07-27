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
    
    var cityFromCoordinates: String?
    
    static let shared = DataFromNetwork()
    
    private(set) var city = ""

    lazy var realm: Realm? = {
        return try? Realm()
    }()
 
    private lazy var parametersForCoordinates: [String: Any] = [
        "apikey": "63f2307a-7e04-4070-a049-6ba223752433",
        "format": "json",
        "geocode": ""
    ]
    
    private var headersForForecast: HTTPHeaders = [
        "User-Agent": "WeatherForecast 0.2 https://github.com/dmkryzh/Weather"
    ]
    
    var parametersForGetForecast: [String: Any] = [
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
    
    func getCityByCoordinates(geocode: String, completion: (() -> Void)? = nil) {
        parametersForCoordinates["geocode"] = geocode
        AF.request("https://geocode-maps.yandex.ru/1.x/", method: .get, parameters: parametersForCoordinates).responseData { response in
            switch response.result {
            case .success(let object):
                let city = DataParser.decodeCity(object)
                self.cityFromCoordinates = city
                
                guard let completion = completion else { return }
                completion()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    func getWeatherForecast(_ city: String, geocode: String? = nil, completion: (()->Void)? = nil) {
        self.city = city
        
        if let geocode = geocode {
            parametersForCoordinates["geocode"] = geocode
        } else {
            parametersForCoordinates["geocode"] = city
        }
        
        AF.request("https://geocode-maps.yandex.ru/1.x/", method: .get, parameters: parametersForCoordinates).responseData { response in
            
            switch response.result {
            case .success(let object):
                
                if let coordinates = DataParser.decodeCoordinates(object) {
                    print(coordinates)
                    self.updateParamsForForecast(coordinates.keys.first ?? "", coordinates.values.first ?? "")
                }

                self.getDataForForecast(self.parametersForGetForecast, completion: completion)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getDataForForecast(_ params: [String: Any], completion: (()->Void)? = nil) {
        
        AF.request("https://api.openweathermap.org/data/2.5/onecall", method: .get, parameters: params, headers: headersForForecast).responseData { response in
            
            switch response.result {
            
            case .success(let object):
                print(response)
                DataParser.decodeForecast(object) { [self] element in
                    DataParser.createEntity(city, ForecastPeriod.current.rawValue, [element.current])
                    DataParser.createEntity(city, ForecastPeriod.hourly.rawValue, element.hourly)
                    DataParser.createEntity(city, ForecastPeriod.daily.rawValue, element.daily)
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
