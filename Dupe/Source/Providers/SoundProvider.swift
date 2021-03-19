//
//  SoundProvider.swift
//  Dupe
//
//  Created by Joshua James on 19.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import AVFoundation

class SoundProvider: NSObject {
    
    var player: AVAudioPlayer?
    var justPlayed: String?
    
    func playRandomTune() {
        let randomMusicSelection = getRandomTuneName()

        justPlayed = randomMusicSelection

        var musicUrl: URL?
        var isMp3 = false
        
        if let mp3Url = Bundle.main.url(forResource: randomMusicSelection, withExtension: "mp3") {
            musicUrl = mp3Url
            isMp3 = true
        } else if let wavUrl =  Bundle.main.url(forResource: randomMusicSelection, withExtension: "wav") {
            musicUrl = wavUrl
        }
        
        guard let url = musicUrl else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            if isMp3 {
                player = try AVAudioPlayer(contentsOf: url,
                                           fileTypeHint: AVFileType.mp3.rawValue)
            } else {
                player = try AVAudioPlayer(contentsOf: url,
                                           fileTypeHint: AVFileType.wav.rawValue)
            }
           

            guard let player = player else { return }

            player.delegate = self
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Private -
    
    private func getRandomTuneName() -> String {
        let randomTuneName = String(format: "%d", Int.random(in: 1..<10))
        
        if randomTuneName == justPlayed {
            return getRandomTuneName()
        } else {
            return randomTuneName
        }
    }
    
}
