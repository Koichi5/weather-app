//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import Foundation

struct HourlyForecast {
    let time: String
    let temperature: Double
    var day: String {
        String(time.prefix(10))
    }
}
