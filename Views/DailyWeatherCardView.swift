//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import SwiftUI

struct DailyWeatherCardView: View {
    let month: Int?
    let day: Int?
    let hourlyForecast: [HourlyForecast]
    private let width: CGFloat = 100
    private let height: CGFloat = 100

    var body: some View {
        NavigationStack {
            NavigationLink (
                destination: {
                    DailyWeatherView(hourlyForecast: hourlyForecast, month: month ?? 0, day: day ?? 0)
            },
                label: {
                    if (month != nil && day != nil) {
                        ZStack {
//                            Text("\(String(month!))月")
//                                .frame(width: width, height: height, alignment: .topLeading)
//                                .padding(20)
                            Text(String(day!))
                                .frame(width: width, height: height, alignment: .center)
                                .font(.system(size: 50))
//                            Text("日")
//                                .frame(width: width, height: heightalignment: .bottomTrailing)
//                                .padding(20)
                        }
                        .frame(width: width, height: height)
                        .clipShape(Rectangle())
                        .cornerRadius(20)
//                        .glassBackgroundEffect()
//                        .frame(width: width, height: height)
//                        .background(Color.red)
//                        .clipShape(Rectangle())
//                        .cornerRadius(20)
//                        Text("\(String(month!))月\(String(day!))日")
//                            .font(.system(size: 30))
//                        .cornerRadius(10)
//                        .shadow(radius: 5)
//                        .padding()
//                        .frame(width: 100, height: 100)
                    } else {
                        Text("日付を取得できません")
                    }
                })
        }
    }
}

//#Preview {
//    DailyWeatherView()
//}
