//
//  GameViewController+GameSessionDelegate.swift
//  Dupe
//
//  Created by Joshua James on 15.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController: GameSessionDelegate {
    
    func gameSessionTriggersGameOver(_ gameSession: GameSession) {
        session?.finishSession()
        
        session = nil
    }
    
    func gameSessionRequestsCollisionGrid(_ gameSession: GameSession) -> Grid? {
        return bigGrid 
    }
    
    func gameSessionTriggersMatch(_ gameSession: GameSession) {
        self.soundProvider.play(sfx: .matched)
    }
    
}
