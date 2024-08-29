//
//  WeatherModel.swift
//  Testair
//
//  Created by Aurimas Vidutis on 27/08/2024.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let description: String
    let iconString: String
    let dt: Int
    
    var temeratureString: String {
        return String(format: "%.1f", temperature)
    }
}
