//
//  MockingNetworkTests.swift
//  WeatherBrickTests
//
//  Created by Екатерина Токарева on 13/01/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import XCTest
@testable import WeatherBrick

final class WeatherNetworkManagerTests: XCTestCase {
    
    private let validData = "{ \"weather\": [ { \"id\": 501, \"main\": \"Rain\" } ], \"main\": { \"temp\": 298.48 }, \"wind\": { \"speed\": 0.62 }, \"name\": \"Zocca\" }".data(using: String.Encoding.utf8)!
    private let notValidData = "{ \"foo\": 42.0, \"main\": \"hello\" }".data(using: String.Encoding.utf8)!
    private var weatherNetworkManager = WeatherNetworkManager()
    private var result: CurrentWeather?
    private let session = URLSessionMock()
    private let latitude = 0.0
    private let longitude = 0.0

    func testSuccessfulNetworkManagerResponse() {
        weatherNetworkManager = WeatherNetworkManager(session: session)
        let data = validData
        let weather = weatherNetworkManager.parseJSON(withData: data)
        session.data = data
        
        result = weatherNetworkManager.fetchCurrentWeather(forLatitude: latitude, longitude: longitude)
        XCTAssertEqual(result, weather)
    }
    
    func testFailNetworkManagerResponse() {
        weatherNetworkManager = WeatherNetworkManager(session: session)
        let data = notValidData
        session.data = data
        
        result = weatherNetworkManager.fetchCurrentWeather(forLatitude: latitude, longitude: longitude)
        XCTAssertEqual(result, nil)
    }
}
