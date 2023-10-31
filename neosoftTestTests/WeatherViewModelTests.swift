//
//  WeatherViewModelTests.swift
//  neosoftTestTests
//
//  Created by Gurmeet Kaur Narang on 31/10/23.
//

import Foundation

@testable import neosoftTest
import XCTest
import CoreLocation

class WeatherViewModelTests: XCTestCase {
    
    var viewModel: WeatherViewModel!
    
    private let weatherService = WeatherService()
    
    var weatherData: ((WeatherData?) -> Void)?
    
    override func setUp() {
        super.setUp()
        viewModel = WeatherViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchWeather() {
            let expectation = XCTestExpectation(description: "Fetch weather expectation")

        weatherService.fetchWeatherData(city: "London") { weather in
            XCTAssertNotNil(weather, "Weather should not be nil")
            XCTAssertNil("Error should be nil")
            expectation.fulfill()
        }
//            viewModel.fetchWeather(for: "London") { weather, error in
//                XCTAssertNotNil(weather, "Weather should not be nil")
//                XCTAssertNil(error, "Error should be nil")
//                expectation.fulfill()
//            }

            wait(for: [expectation], timeout: 5.0)
        }

    }
