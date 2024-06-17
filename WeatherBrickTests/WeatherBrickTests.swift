//
//  WeatherBrickTests.swift
//  WeatherBrickTests
//
//  Created by Екатерина Токарева on 06/01/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import XCTest
@testable import WeatherBrick

final class WeatherBrickTests: XCTestCase {
    
    private let validData = "{ \"weather\": [ { \"id\": 501, \"main\": \"Rain\" } ], \"main\": { \"temp\": 298.48 }, \"wind\": { \"speed\": 0.62 }, \"name\": \"Zocca\" }".data(using: String.Encoding.utf8)!
    private let notValidData = "{ \"foo\": 42.0, \"main\": \"hello\" }".data(using: String.Encoding.utf8)!
    private var weatherNetworkManager = WeatherNetworkManager()
    private var weather = CurrentWeather(weatherData: WeatherData(city: "London", temperature: Temperature(currentTemperature: 10), weather: [Weather(id: 200, description: "foo")], wind: Wind(speed: 5.5)))
    
    func testParseNonJsonString() {
        let data = "Just a plain error".data(using: String.Encoding.utf8)!
        XCTAssertTrue(weatherNetworkManager.parseJSON(withData: data) == nil)
    }
    
    func testParseNonValidJson() {
        XCTAssertTrue(weatherNetworkManager.parseJSON(withData: notValidData) == nil)

    }
    
    func testParseValidJson() {

        XCTAssertTrue(weatherNetworkManager.parseJSON(withData: validData) != nil)
    }
    
    func testWeatherIsWindy() {
        let windSpeed = 12.5
        weather.windSpeed = windSpeed
        XCTAssertTrue(weather.isWindy)
    }
    
    func testWeatherIsNotWindy() {
        let windSpeed = 7.5
        weather.windSpeed = windSpeed
        XCTAssertFalse(weather.isWindy)
    }
    
    func testWeatherIsFoggy() {
        let conditionCode = 701
        weather.conditionCode = conditionCode
        XCTAssertTrue(weather.isFoggy)
    }
    
    func testWeatherIsNotFoggy() {
        let conditionCode = 200
        weather.conditionCode = conditionCode
        XCTAssertFalse(weather.isFoggy)
    }
    
}
