//
//  City.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import Foundation

struct City: Codable, Identifiable, Hashable {
    var id: String { name }
    let name: String
    let latitude: Double
    let longitude: Double
    let timeZone: String
    
    enum CodingKeys: String, CodingKey {
        case name, latitude, longitude
        case timeZone = "time_zone"
    }
}

class SelectedCity: ObservableObject {
    @Published var city = City(name: "", latitude: 0.0, longitude: 0.0, timeZone: "")
}

//let cities: [City] = [
//    City(name: "Tokyo", latitude: 35.6895, longitude: 139.6917, timeZone: "Asia%2FTokyo"),
//    City(name: "Osaka", latitude: 34.686, longitude: 135.520, timeZone: "Asia%2FTokyo")
//]
