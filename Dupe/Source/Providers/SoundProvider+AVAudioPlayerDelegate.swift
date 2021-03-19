//
//  SoundProvider+AVAudioPlayerDelegate.swift
//  Dupe
//
//  Created by Joshua James on 19.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import AVFoundation

extension SoundProvider: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer,
                                     successfully flag: Bool) {
        playRandomTune()
    }
    
}
