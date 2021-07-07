//
//  MappingIcons.swift
//  Weather
//
//  Created by Dmitrii KRY on 07.07.2021.
//

import Foundation


enum WeatherIcon: String {
    case showerRain = "Frame-2"
    case fewClouds = "Group"
    case scatteredClouds = "Frame-3"
    case clearSky = "Frame"
    case thunderstorm = "Frame-1"
    case wind = "wind-1"
    case rain = "Group-1"
    
    static func getMappedIcon(_ icon: String) -> String {
        switch icon {
        case "01d", "01n":
            return "Frame"
        case "02d", "02n", "04d", "04n":
            return "Group"
        case "03d", "03n":
            return "Frame-3"
        case "09d", "09n":
            return "Frame-2"
        case "10d", "10n":
            return "Group-1"
        case "11d", "11n":
            return "Frame-1"
        default:
            return "eya_1"
        }
    }
    
}
