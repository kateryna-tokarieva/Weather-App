//
//  ControllersTests.swift
//  WeatherBrickTests
//
//  Created by Екатерина Токарева on 06/01/2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import WeatherBrick


final class ControllersTests: XCTestCase {
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    private var app: XCUIApplication!
    
    func testInitialWeatherView() {
        let sut = storyboard.instantiateViewController(withIdentifier: "WeatherBrickViewController") as! WeatherBrickViewController
        assertSnapshot(matching: sut, as: .image)
    }

    func testInfoView() {
        let sut = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        assertSnapshot(matching: sut, as: .image)
    }
}
