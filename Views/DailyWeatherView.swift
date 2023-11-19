//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import SwiftUI
import Charts

struct DailyWeatherView: View {
    let hourlyForecast: [HourlyForecast]
    let month: Int
    let day: Int
    @State private var timeList: [Int] = []
    @State private var temperatureList: [Double] = []
    @State private var temperatureData: [TemperatureData] = []
    
    var body: some View {
        VStack {
            Chart(temperatureData) { dataRow in
                LineMark(x: .value("Day", dataRow.day), y: .value("Value", dataRow.value))
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(Color.white)
                    .lineStyle(StrokeStyle(lineWidth: 5))
                    .symbol(.circle)
            }
            .foregroundColor(Color.red)
            .frame(width: 700, height: 400)
        }
        .navigationTitle("\(month)月\(day)日")
        .onAppear {
            for (_, forecast) in hourlyForecast.enumerated() {
                timeList.append(extractHour(from: forecast.time) ?? 0)
                temperatureList.append(forecast.temperature)
            }
            for i in 0..<timeList.count {
                temperatureData.append(.init(day: timeList[i], value: temperatureList[i]))
            }
        }
    }
}

// yyyy-MM-dd'T'HH:mm to HH(Int)
func extractHour(from dateString: String) -> Int? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    
    if let date = dateFormatter.date(from: dateString) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    } else {
        return nil
    }
}

//#Preview {
//    DailyWeatherView()
//}
