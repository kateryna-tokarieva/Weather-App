//
//  WeatherBrickUITestsa.swift
//  WeatherBrickUITests
//
//  Created by Екатерина Токарева on 06/01/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import XCTest
@testable import WeatherBrick

final class WeatherBrickUITestsa: XCTestCase {
    
    private var app: XCUIApplication!
    private lazy var infoButton = app.buttons["INFO_BUTTON"]
    private lazy var hideButton = app.buttons["HIDE_BUTTON"]
    private lazy var image = app.images["IMAGE"]
    private lazy var temperetureLabel = app.staticTexts["TEMPERATURE_LABEL"]
    private lazy var locationLabel = app.staticTexts["LOCATION_LABEL"]

    override func setUp() {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    func testInitialView() {
        XCTAssertTrue(infoButton.exists)
        XCTAssertTrue(image.exists)
        XCTAssertTrue(temperetureLabel.exists)
        XCTAssertTrue(locationLabel.exists)
    }
 
    func testInfoView() {
        infoButton.tap()
        XCTAssertTrue(hideButton.exists)
    }
    
    func testBackToWeatherView() {
        infoButton.tap()
        hideButton.tap()
        XCTAssertTrue(infoButton.exists)
    }
}
