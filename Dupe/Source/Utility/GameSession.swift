//
//  GameSession.swift
//  Dupe
//
//  Created by Joshua James on 15.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

protocol GameSessionDelegate {
        
    func gameSessionTriggersGameOver(_ gameSession: GameSession)
    
    func gameSessionTriggersMatch(_ gameSession: GameSession,
                                  withGainedScore gainedScore: Int,
                                  withMatchedGrid matchedGrid: Grid)
    
    func gameSessionRequestsCollisionGrid(_ gameSession: GameSession) -> Grid?
    
    func gameSessionTriggersNewGridSpawn(_ gameSession: GameSession, in position: Position)
    
}

class GameSession {
        
    var delegate: GameSessionDelegate
    var currentScore: Int = 0
    var velocity: TimeInterval = 0.1
    var currentSpawnSpeed: TimeInterval = Constants.Values.initialSpawnTime
    var grids: [Grid] = []
    
    required init(withDelegate delegate: GameSessionDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        finishSession()
    }
        
    // MARK: - Helper -
    
    func finishSession() {        
        if currentScore > 0 {
            HighScores.save(score: currentScore)
        }
        
        for grid in grids {
            grid.removeFromSuperview()
        }
    }
    
}
