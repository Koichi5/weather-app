//
//  WeatherRealityDetailView.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/23.
//

import SwiftUI

import SwiftUI

struct WeatherRealityDetailView: View {
    let city: String
    let weater: String
    var body: some View {
        VStack {
            Text(city)
            Text(weater)
        }
    }
}
