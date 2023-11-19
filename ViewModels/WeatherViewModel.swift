////
////  WeatherViewModel.swift
////  WeatherApp
////
////  Created by Koichi Kishimoto on 2023/11/18.
////
//
//import SwiftUI
//import Foundation
//
//// MARK: - Temperatures
//struct Temperatures: Codable {
////   let coord: Coord
//   let weather: [Weather]
//   let base: String
//   let main: Main
//   let visibility: Int
//   let wind: Wind
//   let clouds: Clouds
//   let dt: Int
//   let sys: Sys
//   let timezone, id: Int
//   let name: String
//   let cod: Int
//}
//
//// MARK: - Clouds
//struct Clouds: Codable {
//   let all: Int
//}
//
//// MARK: - Coord
////struct Coord: Codable {
////   let lon, lat: Double
////}
//
//// MARK: - Main
//struct Main: Codable {
//   let temp, feelsLike, tempMin, tempMax: Double
//   let pressure, humidity: Int
//
//   enum CodingKeys: String, CodingKey {
//       case temp
//       case feelsLike = "feels_like"
//       case tempMin = "temp_min"
//       case tempMax = "temp_max"
//       case pressure, humidity
//   }
//}
//
//// MARK: - Sys
//struct Sys: Codable {
//   let type, id: Int
//   let country: String
//   let sunrise, sunset: Int
//}
//
//// MARK: - Weather
//struct Weather: Codable {
//   let id: Int
//   let main, weatherDescription, icon: String
//
//   enum CodingKeys: String, CodingKey {
//       case id, main
//       case weatherDescription = "description"
//       case icon
//   }
//}
//
//// MARK: - Wind
//struct Wind: Codable {
//   let speed: Double
//   let deg: Int
//}
//
////  結果を戻す関数型定義
//typealias RecvFunc = ((_ item:Temperatures)->Void)?
//// 天気予報を取得するクラス
//class WeatherViewModel: ObservableObject {
//    // Use @Published for automatic view updates
//    @Published var temperatures: Temperatures?
//
//    // Error handling
////    @Published var errorMessage: String?
//
//    init() {
//        let openWeatherApiKey: String = {
//            return Bundle.main.object(forInfoDictionaryKey: "OpenWeatherApiKey") as! String
//        } ()
//        let urlString =
//        "https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=hourly,daily&appid=\(openWeatherApiKey)"
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
////        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
////            DispatchQueue.main.async {
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//
//            guard let data = data else {
//                print("Invalid data")
//                return
//            }
//
//            do {
//                let decorder = JSONDecoder()
//                let temperatures = try decorder.decode(Temperatures.self, from: data)
//                DispatchQueue.main.async {
//                    self.temperatures = temperatures
//                    print(temperatures)
//                }
//            } catch let error {
//                print("Error decoding JSON: \(error)")
//            }
////                guard let data = data, let decodedResponse = try? JSONDecoder().decode(Temperatures.self, from: data) else {
////                    print("Failed to decode response")
////                    return
////                }
////                self.temperatures = decodedResponse
////                print("decodedResponse : \(decodedResponse)")
////            }
//        }.resume()
//    }
//}
//
//
////class WeatherViewModel {
////    // OpenWeatherMapのAPIから天気情報を取得
////    public func getWether() {
////        let latitude = "34.0778755" // 緯度 (徳島大学の座標)
////        let longitude = "134.5615651" // 経度
////        let API_KEY = "xxx"
////        let parameter = "lat=\(latitude)&lon=\(longitude)&appid=\(API_KEY)&lang=ja&units=metric"
////
////        let urlStr = "https://api.openweathermap.org/data/2.5/weather?" + parameter
////
////        state?(.busy) // 通信開始（通信中）
////        apiManager.request(urlStr,
////                           success: { [weak self] (response) in
////
////            guard let self = self else { // HomeViewModelのself
////                AKLog(level: .FATAL, message: "[self] FatalError")
////                fatalError()
////            }
////
////            // 天気の様子が返ってくる 例: 曇
////            self.weatherDiscription = response["weather"][0]["description"].string ?? "Error"
////
////            // 体感気温がdoubleの形で返ってくる　例: 21.52
////            if let temp = response["main"]["feels_like"].double {
////                var tempStr = String(temp) // 例: "21.52"
////
////                // "21.5"の時は4桁
////                if tempStr.count == 5 {
////                    tempStr = String(tempStr.prefix(tempStr.count-1)) // 例: "21.5"
////                }
////                self.weatherFeelsLike = tempStr + "℃" // 例: "21.5℃"
////            }
////
////            // 天気を表すアイコンコードが返ってくる 例 "02d"
////            if let iconCode = response["weather"][0]["icon"].string {
////                let urlStr = "https://openweathermap.org/img/wn/" + iconCode + "@2x.png"
////                self.weatherIconUrlStr = urlStr
////            }
////
////            self.state?(.ready) // 通信完了
////
////        }, failure: { [weak self] (error) in
////            AKLog(level: .ERROR, message: "[API] userUpdate: failure:\(error.localizedDescription)")
////            self?.state?(.error) // エラー表示
////        })
////    }
////
////}

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherData: Weather?
    
    func fetchWeatherData(latitude: String, longitude: String, timeZone: String) {
//    https://api.open-meteo.com/v1/forecast?latitude=35.6895&longitude=139.6917&current=temperature_2m,rain,weather_code&hourly=temperature_2m,rain,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=Asia%2FTokyo
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,rain,weather_code&hourly=temperature_2m,rain,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=\(timeZone)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(Weather.self, from: data)
                        self.weatherData = decodedData
                    } catch {
                        print("Error decoding: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                }
            }
        }.resume()
    }
}
