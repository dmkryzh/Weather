//
//  ForecastData.swift
//  Weather
//
//  Created by Dmitrii KRY on 22.07.2021.
//

import Foundation

protocol WeatherProtocol {
    var dt: Double { get }
    var sunrise: Int? { get }
    var sunset: Int? { get }
    var moonset: Int? { get }
    var moonrise: Int? { get }
    var moonPhase: Double? { get }
    var temperature: Temp? { get }
    var currentTemp: Double? { get }
    var feelsLikeArray: FeelsLike? { get }
    var feelsLikeTemp: Double? { get }
    var pressure: Int { get }
    var humidity: Int { get }
    var dewPoint: Double { get }
    var uvi: Double { get }
    var pop: Double? { get }
    var clouds: Int { get }
    var visibility: Int? { get }
    var windSpeed: Double { get }
    var windGust: Double? { get }
    var windDeg: Double { get }
    var weather: [Weather] { get }
    var dailyRain: Double? { get }
    var currentRain: Rain? { get }
}

// MARK: - Forecast
struct Forecast: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Current]
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - Current
struct Current: Codable, WeatherProtocol {
    let dt: Double
    let sunrise, sunset: Int?
    let moonset, moonrise: Int?
    let moonPhase: Double?
    let temperature: Temp?
    let currentTemp: Double?
    let feelsLikeArray: FeelsLike?
    let feelsLikeTemp: Double?
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let pop: Double?
    let clouds: Int
    let visibility: Int?
    let windSpeed: Double
    let windGust: Double?
    let windDeg: Double
    let weather: [Weather]
    let dailyRain: Double?
    let currentRain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case temperature
        case currentTemp = "temp"
        case moonPhase = "moon_phase"
        case feelsLikeArray
        case feelsLikeTemp = "feels_like"
        case pressure, humidity, visibility
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi
        case currentRain = "rain"
        case dailyRain
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Daily
struct Daily: Codable, WeatherProtocol {
    let dt: Double
    let sunrise, sunset: Int?
    let moonset, moonrise: Int?
    let moonPhase: Double?
    let temperature: Temp?
    let currentTemp: Double?
    let feelsLikeArray: FeelsLike?
    let feelsLikeTemp: Double?
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let pop: Double?
    let clouds: Int
    let visibility: Int?
    let windSpeed: Double
    let windGust: Double?
    let windDeg: Double
    let weather: [Weather]
    let dailyRain: Double?
    let currentRain: Rain?
    
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case temperature = "temp"
        case currentTemp
        case moonPhase = "moon_phase"
        case feelsLikeArray = "feels_like"
        case feelsLikeTemp
        case pressure, humidity, visibility
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi
        case dailyRain = "rain"
        case currentRain
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double?
    let feelsLike: Double?
}

// MARK: - Temp
struct Temp: Codable {
    let temp: Double?
    let day, min, max, night: Double?
    let eve, morn: Double?
}
