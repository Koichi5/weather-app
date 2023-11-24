//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/18.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
        WindowGroup(id: "WeatherRealityView") {
            WeatherRealityView(city: "Tokyo", weather: "Sunny")
        }
        .defaultSize(CGSize(width: 800, height: 1000))

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
