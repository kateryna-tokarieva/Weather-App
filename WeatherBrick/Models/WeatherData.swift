//
//  WeatherData.swift
//  WeatherBrick
//
//  Created by Екатерина Токарева on 23/12/2022.
//  Copyright © 2022 VAndrJ. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let city: String
    let temperature: Temperature
    let weather: [Weather]
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case temperature = "main"
        case weather
        case wind
    }
}

