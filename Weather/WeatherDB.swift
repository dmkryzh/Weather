//
//  WeatherDB.swift
//  Weather
//
//  Created by Dmitrii KRY on 03.07.2021.
//

import Foundation
import RealmSwift

//class CityPoint: Object {
//    @objc dynamic var pos: [String: Any] = [
//        "lat": "",
//        "lon": ""
//    ]
//
//    @objc dynamic var city = ""
//
//    static func create(latitude: String, longtitude: String, city: String) -> CityPoint {
//        let coordinates = CityPoint()
//        coordinates.pos["lat"] = latitude
//        coordinates.pos["lon"] = longtitude
//        coordinates.city = city
//        return coordinates
//    }
//}


class WeatherForecast: Object {
    @objc dynamic var city = ""
    @objc dynamic var forecastType = ""
    @objc dynamic var dt = 0
    @objc dynamic var sunrise = 0
    @objc dynamic var sunset = 0
    @objc dynamic var moonrise = 0
    @objc dynamic var moonset = 0
    @objc dynamic var moonPhase = 0.0
    @objc dynamic var tempDay = 0.0
    @objc dynamic var tempMin = 0.0
    @objc dynamic var tempMax = 0.0
    @objc dynamic var tempNight = 0.0
    @objc dynamic var tempEve = 0.0
    @objc dynamic var tempMorn = 0.0
    @objc dynamic var feelsLikeDay = 0.0
    @objc dynamic var feelsLikeNight = 0.0
    @objc dynamic var feelsLikeEve = 0.0
    @objc dynamic var feelsLikeMorn = 0.0
    @objc dynamic var pressure = 0
    @objc dynamic var humidity = 0
    @objc dynamic var dewPoint = 0.0
    @objc dynamic var windSpeed = 0.0
    @objc dynamic var windDeg = 0.0
    @objc dynamic var windGust = 0.0
    @objc dynamic var weatherId = 0
    @objc dynamic var weatherMain = ""
    @objc dynamic var weatherDescription = ""
    @objc dynamic var weatherIcon = ""
    @objc dynamic var clouds = 0
    @objc dynamic var pop = 0
    @objc dynamic var uvi = 0.0
}

//class Properties: Object {
//
//}