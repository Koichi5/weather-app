//
//  Tokyo.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import Foundation

struct Tokyo: Codable {
    let latitude: Double = 35.6895
    let longitude: Double = 139.6917
    let timeZone: String = "Asia%2FTokyo"
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case timeZone = "time_zone"
    }
}
