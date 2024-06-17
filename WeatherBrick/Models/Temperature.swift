//
//  Main.swift
//  WeatherBrick
//
//  Created by Екатерина Токарева on 03/01/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import Foundation

struct Temperature: Codable {
    let currentTemperature: Double
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
    }
}
