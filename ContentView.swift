//
//  ContentView.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/18.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    @State private var player = AVQueuePlayer()
    @State private var selectedCity: City?
    let cities: [City] = [
        City(name: "Tokyo", latitude: 35.6895, longitude: 139.6917, timeZone: "Asia%2FTokyo"),
        City(name: "Osaka", latitude: 34.686, longitude: 135.520, timeZone: "Asia%2FTokyo")
    ]
    
    var groupedWeather: [String: [HourlyForecast]] {
        Dictionary(grouping: viewModel.weatherData?.hourly.time.enumerated().map { (index, time) in
            HourlyForecast(time: time, temperature: viewModel.weatherData!.hourly.temperature2M[index])
        } ?? [], by: { $0.day })
    }
    
    init() {
        _selectedCity = State(initialValue: cities[0])
    }
        
    var body: some View {
        NavigationSplitView {
            List(cities, id: \.self, selection: $selectedCity) { city in
                Text(city.name)
            }
            .onChange(of: selectedCity) {
                viewModel.fetchWeatherData(
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
                        .font(.system(size: 20))
                    viewModel.weatherData != nil ? Text("\(Int(viewModel.weatherData!.current.temperature2M))°").font(.system(size: 50)) : Text("気温取得中...")
                    HStack {
                        VStack {
                            Text("最高気温")
                            viewModel.weatherData != nil ? Text("\(Int(viewModel.weatherData!.daily.temperature2MMax[0]))°").font(.system(size: 40)) : Text("気温取得中...")
                        }
                        VStack {
                            Text("最低気温")
                            viewModel.weatherData != nil ? Text("\(Int(viewModel.weatherData!.daily.temperature2MMin[0]))°").font(.system(size: 40)) : Text("気温取得中...")
                        }
                    }
    //                Text(currentWeatherDescription)
                    viewModel.weatherData != nil ? Text("\(weatherDescription(from: viewModel.weatherData!.current.weatherCode))").font(.system(size: 40)) : Text("天気情報...")
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
            }
        }
        .background {
            ZStack {
                Image("Sunny\(selectedCity!.name)")
                .ignoresSafeArea()
                Color.blue.opacity(0.8)
                    .blendMode(.softLight)
//                Circle()
//                    .fill(RadialGradient(colors: [Color.blue, Color.blue.opacity(0.8)], center: .center, startRadius: 50, endRadius: 1500))
//                    .blendMode(.softLight)
//                Color.blue.opacity(0.1)
//                    .blendMode(.softLight)
            }
        }
        .onAppear {
            // 初期値では東京の緯度・経度を入力
            let tokyo = Tokyo()
            viewModel.fetchWeatherData(
                latitude: String(tokyo.latitude),
                longitude: String(tokyo.longitude),
                timeZone: tokyo.timeZone
            )
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
