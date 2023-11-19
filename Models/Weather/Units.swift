//
//  Units.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import Foundation

struct Units: Codable {
    let time: String
    let interval: String?
    let temperature2M, rain, weatherCode: String

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case rain
        case weatherCode = "weather_code"
    }
}
