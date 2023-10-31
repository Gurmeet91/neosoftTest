//
//
//  WeatherData.swift
//  neosoftTest
//
//  Created by Gurmeet Kaur Narang on 30/10/23.
//

import Foundation
struct WeatherData: Decodable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
