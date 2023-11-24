//
//  Current.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import Foundation

struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M: Double
    let rain: Double
    let weatherCode: Int

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case rain
        case weatherCode = "weather_code"
    }
}
