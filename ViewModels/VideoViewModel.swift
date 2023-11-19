//
//  VideoViewModel.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/19.
//

import SwiftUI
import AVKit
import AVFoundation

final class WelcomeVideoController : UIViewControllerRepresentable {
    var playerLooper: AVPlayerLooper?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<WelcomeVideoController>) ->
        AVPlayerViewController {
            let controller = AVPlayerViewController()
            controller.showsPlaybackControls = false
            
            guard let path = Bundle.main.path(forResource: "welcome", ofType:"mp4") else {
                debugPrint("welcome.mp4 not found")
                return controller
            }
                    
            let asset = AVAsset(url: URL(fileURLWithPath: path))
            let playerItem = AVPlayerItem(asset: asset)
            let queuePlayer = AVQueuePlayer()
            // OR let queuePlayer = AVQueuePlayer(items: [playerItem]) to pass in items
            
            playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
            queuePlayer.play()
            controller.player = queuePlayer
                
            return controller
        }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<WelcomeVideoController>) {
    }
}
