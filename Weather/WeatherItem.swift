//
//  WeatherItem.swift
//  Weather
//
//  Created by Абай Бауржан on 22.12.2024.
//

import Foundation
import SwiftyJSON

struct WeatherItem {
    var weatherTemperature = ""
    var weatherWind = ""
    var weatherDescription = ""

    init(json: JSON) {
        if let temp = json["main"]["temp"].double {
            weatherTemperature = "\(temp)°C"
        }
        if let wind = json["wind"]["speed"].double {
            weatherWind = "\(wind) м/с"
        }
        if let description = json["weather"][0]["description"].string {
            weatherDescription = description.capitalized
        }
    }
}
