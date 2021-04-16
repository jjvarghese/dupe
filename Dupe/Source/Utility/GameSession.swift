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
        
    func gameSessionTriggersMatch(_ gameSession: GameSession)
    
    func gameSessionRequestsCollisionGrid(_ gameSession: GameSession) -> Grid?
        
    func gameSessionRequestsInitialTempo(_ gameSession: GameSession,
                                         initialTempo: @escaping (TimeInterval) -> Void)
    
}

class GameSession {
    
    typealias GriddableGameSessionDelegate = GameSessionDelegate & Griddable
    
    var delegate: GriddableGameSessionDelegate
    
    var currentScore: Int = 0
    var tempo: TimeInterval = 0
    var grids: [Grid] = []
    
    required init(withDelegate delegate: GriddableGameSessionDelegate) {
        self.delegate = delegate
        
        delegate.gameSessionRequestsInitialTempo(self) { [weak self] (initialTempo) in
            self?.tempo = initialTempo
        }
    }
    
    deinit {
        if currentScore > 0 {
            HighScores.save(score: currentScore)
        }
        
        for grid in grids {
            grid.removeFromSuperview()
        }
        
        showScore()
    }
    
    // MARK: - Gameplay -

    private func showScore() {
        let scoreString = String(format: "%@%d\n\n%@",
                                 Constants.Text.gameOverHeadline,
                                 currentScore,
                                 Constants.Text.ScoreJudgements.getJudgement(forScore: currentScore))
        
        NotificationView.popin(withText: scoreString)
    }
}
