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
    
    static private let NUMBER_OF_MUSIC_TRACKS = 15
    
    var musicPlayer: AVAudioPlayer?
    var sfxPlayer: AVAudioPlayer?
    var justPlayed: String?
    
    func play(sfx: SFX,
              bundle: BundleProtocol = Bundle.main,
              withCompletion completion: (() -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            guard let sfxUrl = bundle.url(forResource: sfx.rawValue) else {
                return
            }
            
            self?.playAudio(url: sfxUrl,
                      asTune: false,
                            withCompletion: completion)
        }
        
    }
    
    func stopAllTunes() {
        musicPlayer?.stop()
    }
    
    func playRandomTune(bundle: BundleProtocol = Bundle.main,
                        withCompletion completion: (() -> Void)? = nil) {
        let randomMusicSelection = getRandomTuneName()

        justPlayed = randomMusicSelection
        
        guard let url = bundle.url(forResource: randomMusicSelection) else { return }

        playAudio(url: url,
                  asTune: true,
                  withCompletion: completion)
    }
    
    // MARK: - Private -
    
    private func playAudio(url: URL,
                           asTune: Bool,
                           withCompletion completion: (() -> Void)?) {
        let category: AVAudioSession.Category = asTune ? .playback : .ambient
        var player: AVAudioPlayer?
        
        do {
            try AVAudioSession.sharedInstance().setCategory(category,
                                                            mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            if url.pathExtension == "mp3" {
                player = try AVAudioPlayer(contentsOf: url,
                                           fileTypeHint: AVFileType.mp3.rawValue)
            } else {
                player = try AVAudioPlayer(contentsOf: url,
                                           fileTypeHint: AVFileType.wav.rawValue)
            }

            guard let player = player else { return }
            
            if asTune {
                musicPlayer = player
                musicPlayer?.delegate = self
            } else {
                sfxPlayer = player
            }
            
            player.play()
            
            if let completion = completion {
                completion()
            }
        } catch let error {
            print(error.localizedDescription)
            
            if let completion = completion {
                completion()
            }
        }
    }
    
    private func getRandomTuneName() -> String {
        let randomTuneName = String(format: "%d",
                                    Int.random(in: 1...SoundProvider.NUMBER_OF_MUSIC_TRACKS))
        
        if randomTuneName == justPlayed {
            return getRandomTuneName()
        } else {
            return randomTuneName
        }
    }
    
}
