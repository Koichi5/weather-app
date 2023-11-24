//
//  Hourly.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import Foundation

struct Hourly: Codable {
    let time: [String]
    let temperature2M: [Double]
    let rain: [Double]
    let weatherCode: [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case rain
        case weatherCode = "weather_code"
    }
}
