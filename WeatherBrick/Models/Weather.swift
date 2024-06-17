//
//  Weather.swift
//  WeatherBrick
//
//  Created by Екатерина Токарева on 03/01/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "main"
    }
}
