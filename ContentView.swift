//
//  ContentView.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/18.
//

import SwiftUI
import AVFoundation
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @ObservedObject var locationViewModel = LocationViewModel()
    @State private var player = AVQueuePlayer()
    @State private var selectedCity: City?
    var currentLat: Double = 0.0
    var currentLon: Double = 0.0
    var cities: [City] = []
    
    var groupedWeather: [String: [HourlyForecast]] {
        Dictionary(grouping: weatherViewModel.weatherData?.hourly.time.enumerated().map { (index, time) in
            HourlyForecast(time: time, temperature: weatherViewModel.weatherData!.hourly.temperature2M[index], weatherCode: weatherViewModel.weatherData!.hourly.weatherCode[index])
        } ?? [], by: { $0.day })
    }
    
    init() {
        currentLat = $locationViewModel.location.wrappedValue.coordinate.latitude
        currentLon = $locationViewModel.location.wrappedValue.coordinate.longitude
        
        weatherViewModel.fetchWeatherData(
            latitude: String(currentLat),
            longitude: String(currentLon),
            timeZone: "Asia%2FTokyo"
        )
        cities = [
            City(name: "Current", latitude: currentLat, longitude: currentLon, timeZone: "Asia%2FTokyo"),
            City(name: "Tokyo", latitude: 35.6895, longitude: 139.6917, timeZone: "Asia%2FTokyo"),
            City(name: "Osaka", latitude: 34.686, longitude: 135.520, timeZone: "Asia%2FTokyo"),
            City(name: "Nagoya", latitude: 35.1709, longitude: 136.8815, timeZone: "Asia%2FTokyo"),
            City(name: "Hokkaido", latitude: 43.0614, longitude: 141.3538, timeZone: "Asia%2FTokyo"),
            City(name: "Okinawa", latitude: 26.2123, longitude: 127.6790, timeZone: "Asia%2FTokyo"),
        ]
        _selectedCity = State(initialValue: cities[0])
    }
    
    var body: some View {
        NavigationSplitView {
            List(cities, id: \.self, selection: $selectedCity) { city in
                Text(city.name)
            }
            .onChange(of: selectedCity) {
                weatherViewModel.fetchWeatherData(
                    latitude: String(selectedCity!.latitude),
                    longitude: String(selectedCity!.longitude),
                    timeZone: selectedCity!.timeZone
                )
            }
            .navigationTitle("City")
        } detail: {
            if let selectedCity {
                VStack {
                    Text(selectedCity.name)
                        .font(.system(size: 30))
                    weatherViewModel.weatherData != nil ? Text("\(Int(weatherViewModel.weatherData!.current.temperature2M))°").font(.system(size: 60)) : Text("気温取得中...")
                    HStack {
                        VStack {
                            Text("最高気温")
                                .font(.system(size: 30))
                            weatherViewModel.weatherData != nil ? Text("\(Int(weatherViewModel.weatherData!.daily.temperature2MMax[0]))°").font(.system(size: 50)) : Text("気温取得中...")
                        }
                        VStack {
                            Text("最低気温")
                                .font(.system(size: 30))
                            weatherViewModel.weatherData != nil ? Text("\(Int(weatherViewModel.weatherData!.daily.temperature2MMin[0]))°").font(.system(size: 50)) : Text("気温取得中...")
                        }
                    }
                    .padding(10)
                    weatherViewModel.weatherData != nil ? Text("\(weatherDescription(from: weatherViewModel.weatherData!.current.weatherCode))").font(.system(size: 40)) : Text("天気情報...")
                    VStack(alignment: .leading){
                        Text("週間天気")
                            .font(.system(size: 30))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(groupedWeather.keys.sorted(), id: \.self) { day in
                                    if let forecasts = groupedWeather[day] {
                                        let formattedMonth = getMonth(from: day)
                                        let formattedDay = getDay(from: day)
                                        DailyWeatherCardView(month: formattedMonth, day: formattedDay, hourlyForecast: forecasts)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Weather")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if weatherViewModel.weatherData != nil {
                                openWindow(id: "WeatherRealityView")
                                //                            WeatherRealityView(city: selectedCity.name, weather: weatherDescriptionInEnglish(from: weatherViewModel.weatherData!.current.weatherCode))
                            }
                        }) {
                            Text("Open in volume")
                        }                    }
                }
            }
        }
        .background {
            ZStack {
                Image("Sunny\(selectedCity!.name)")
                    .ignoresSafeArea()
                Color.blue.opacity(0.8)
                    .blendMode(.softLight)
            }
        }
    }
}

// yyyy-MM-dd to MM月dd日(String)
func formatDate(_ dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
    let outputFormatter = DateFormatter()
    outputFormatter.locale = Locale(identifier: "ja_JP")
    outputFormatter.dateFormat = "M月d日"
    
    if let date = inputFormatter.date(from: dateString) {
        return outputFormatter.string(from: date)
    } else {
        return "不正な日付"
    }
}

// yyyy-MM-dd to MM(Int)
func getMonth(from dateString: String) -> Int? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    if let date = formatter.date(from: dateString) {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        return month
    } else {
        return nil
    }
}

// yyyy-MM-dd to dd(Int)
func getDay(from dateString: String) -> Int? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    if let date = formatter.date(from: dateString) {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return day
    } else {
        return nil
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
