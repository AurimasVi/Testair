//
//  WeatherData.swift
//  Testair
//
//  Created by Aurimas Vidutis on 27/08/2024.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Int
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let icon: String
    let description: String
}
