//
//  WeatherRealityView.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/23.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct WeatherRealityView: View {
    let city: String
    let weather: String
    @ObservedObject var weatherViewModel = WeatherViewModel()
    
    @State private var cityEntity: Entity?
    @State private var weatherEntity: Entity?
    let attachmentID = "attachmentID"
    var body: some View {
        RealityView { content, attachments in
            guard let cityEntity = try? await Entity(named: city, in: realityKitContentBundle) else {
                fatalError("Unable to load city scene model")
            }
            content.add(cityEntity)
            self.cityEntity = cityEntity
            
            guard let weatherEntity = try? await Entity(named: weather, in: realityKitContentBundle) else {
                fatalError("Unable to load weather scene model")
            }
            content.add(weatherEntity)
            self.weatherEntity = weatherEntity
            
            if let sceneAttachment = attachments.entity(for: attachmentID) {
                sceneAttachment.position = SIMD3<Float>(-0.2, -0.1, 0.1)
                content.add(sceneAttachment)
            }
        } update: { content, attachments in
            print("RealityView changes detected ...")
        } placeholder: {
            ProgressView()
                .progressViewStyle(.circular)
                .controlSize(.large)
                .frame(width: 800, height: 1000, alignment: .center)
        } attachments: {
            Attachment(id: attachmentID) {
                WeatherRealityDetailView(city: city, weater: weather)
            }
        }
    }
}

//#Preview {
//    WeatherRealityView()
//}
