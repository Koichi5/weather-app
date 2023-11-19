//
//  TemperatureData.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import Foundation

struct TemperatureData: Identifiable {
    var id: Int { day }
    var day: Int
    var value: Double
}
