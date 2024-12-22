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
        if let item = json["temperature"].string {
            weatherTemperature = item
        }
        if let item = json["wind"].string {
            weatherWind = item
        }
        if let item = json["description"].string {
            weatherDescription = item
        }
    }
}

