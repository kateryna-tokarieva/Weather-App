//
//  CurrentWeather.swift
//  WeatherBrick
//
//  Created by Екатерина Токарева on 23/12/2022.
//  Copyright © 2022 VAndrJ. All rights reserved.
//

import Foundation

struct CurrentWeather: Equatable {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature) + "°"
    }
    var isFoggy: Bool {
        conditionCode >= 701 && conditionCode <= 781
    }
    var windSpeed: Double
    var isWindy: Bool {
        windSpeed > 10
    }
    var conditionCode: Int
    var iconNameString: String {
        guard temperature > 27 else {
            switch conditionCode {
            case 200...531: return "image_stone_wet"
            case 600...622: return "image_stone_snow"
            case 701...781: return "image_stone_normal"
            case 800...804: return "image_stone_normal"
            default: return ""
            }
        }
        return "image_stone_cracks"
    }
    
    let description: String
    
    init(weatherData: WeatherData) {
        cityName = weatherData.city
        temperature = weatherData.temperature.currentTemperature
        conditionCode = weatherData.weather.first?.id ?? 0
        description = weatherData.weather.first?.description ?? ""
        windSpeed = weatherData.wind.speed
    }
}
