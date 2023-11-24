//
//  Weather.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import Foundation

struct Weather: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: Units
    let current: Current
    let hourlyUnits: Units
    let hourly: Hourly
    let dailyUnits: DailyUnits
    let daily: Daily

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
        case hourlyUnits = "hourly_units"
        case hourly
        case dailyUnits = "daily_units"
        case daily
    }
}

func weatherDescription(from code: Int) -> String {
    switch code {
    case 0:
        return "晴れ"
    case 1, 2, 3:
        return "主に晴れ、一部曇り、曇り"
    case 45, 48:
        return "霧、着氷霧"
    case 51, 53, 55:
        return "霧雨: 弱い、中程度、強い"
    case 56, 57:
        return "着氷性の霧雨: 弱い、強い"
    case 61, 63, 65:
        return "雨: 小雨、中雨、大雨"
    case 66, 67:
        return "着氷性の雨: 弱い、強い"
    case 71, 73, 75:
        return "雪: 小雪、中雪、大雪"
    case 77:
        return "霙（みぞれ）"
    case 80, 81, 82:
        return "にわか雨: 弱い、中程度、激しい"
    case 85, 86:
        return "にわか雪: 弱い、強い"
    case 95:
        return "雷雨: 弱いまたは中程度"
    case 96, 99:
        return "雷雨: 小さい、大きいひょうを伴う"
    default:
        return "不明"
    }
}

func weatherDescriptionInEnglish(from code: Int) -> String {
    switch code {
    case 0:
        return "Sunny"
    case 1, 2, 3:
        return "Cloudy"
    case 45, 48:
        return "Fog"
    case 51, 53, 55:
        return "Drizzle"
    case 56, 57:
        return "FreezingDrizzle"
    case 61, 63, 65:
        return "Rain"
    case 66, 67:
        return "FreezingRain"
    case 71, 73, 75:
        return "Snow"
    case 77:
        return "Sleet"
    case 80, 81, 82:
        return "Showers"
    case 85, 86:
        return "SnowShowers"
    case 95:
        return "Thunderstorm"
    case 96, 99:
        return "ThunderstormWithHail"
    default:
        return "Unknown"
    }
}
