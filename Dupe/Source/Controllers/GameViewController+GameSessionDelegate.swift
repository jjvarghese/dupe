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
    
    func gameSessionTriggersNewGridSpawn(_ gameSession: GameSession,
                                         in position: Position) {
        let grid = Grid(withDelegate: self)
        
        grid.position = position
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            gameSession.grids.add(grid: grid)
            
            self.view.addSubviewWithConstraints(subview: grid,
                                                    atPosition: position,
                                                    withWidth: self.view.frame.size.height / 5,
                                                    withHeight: self.view.frame.size.height / 5)
            
            grid.randomise()
            grid.accessibilityIdentifier = "SmallGrid"
        }
        
    }
    
    func gameSessionTriggersGameOver(_ gameSession: GameSession) {
        UILabel.spawnFloatingFadingLabel(toSuperview: view,
                                         withText: Constants.Text.collisionText)
        
        showScore(score: gameSession.currentScore)
        
        session?.finishSession()
        
        session = nil
        
        soundProvider.play(sfx: .gameOver)
        soundProvider.stopAllTunes()
    }
    
    func gameSessionRequestsCollisionGrid(_ gameSession: GameSession) -> Grid? {
        return bigGrid 
    }
    
    func gameSessionTriggersMatch(_ gameSession: GameSession,
                                  withGainedScore gainedScore: Int,
                                  withMatchedGrid matchedGrid: Grid) {
        self.soundProvider.play(sfx: .matched)
        
        UILabel.spawnFloatingFadingLabel(toSuperview: view,
                                         withFrame: matchedGrid.frame,
                                         withColor: matchedGrid.rubikColor.color(),
                                         withText: String(format: "%d", gainedScore))
    }
    
    // MARK: - Private -
    
    private func showScore(score: Int) {
        guard let color = bigGrid?.rubikColor else { return }

        let scoreString = String(format: "%@%d\n\n%@",
                                 Constants.Text.gameOverHeadline,
                                 score,
                                 Constants.Text.ScoreJudgements.getJudgement(forScore: score))
        
        NotificationView.popin(withText: scoreString,
                               withColor: color)
    }
    
}
