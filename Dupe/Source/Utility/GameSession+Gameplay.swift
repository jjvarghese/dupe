//
//  GameSession+ScoreKeeping.swift
//  Dupe
//
//  Created by Joshua James on 15.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameSession {
    
    func triggerMatch(matchedGrid: Grid) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.delegate.gameSessionTriggersMatch(self)
            
            let collisionGrid = self.delegate.gameSessionRequestsCollisionGrid(self)
            
            collisionGrid?.reset()
            
            self.grids.removeAll { (onScreenGrid) -> Bool in
                return matchedGrid == onScreenGrid
            }
            
            if matchedGrid.position == .center {
                self.spawnGrid(in: .center)
            }
            
            let numberOfPointsToGain = self.getNumberOfPointsToGain(matchedGrid: matchedGrid)
            
            UILabel.spawnFloatingFadingLabel(toSuperview: self.delegate.view,
                                             withText: String(format: "%d", numberOfPointsToGain))
            
            self.currentScore += numberOfPointsToGain
            
            if self.tempo <= Constants.Values.thresholdTempoForExtraSpawns {
                let randomNumber = Int.random(in: 0..<5)
                
                if randomNumber == 0 {
                    Timer.scheduledTimer(timeInterval: Constants.Values.sideGridSpawnDelay,
                                         target: self,
                                         selector: #selector(self.spawnSideGrid),
                                         userInfo: nil,
                                         repeats: false)
                }
            }
            
            matchedGrid.removeFromSuperview()
            
            self.rotateColors()
        }
    }
    
    // MARK: - Private -
    
    private func rotateColors() {
        UIColor.baseRubikColor = RubikColor.getRandomRubikColor()
        
        let collisionGrid = delegate.gameSessionRequestsCollisionGrid(self)
        
        collisionGrid?.reloadData()
        
        for grid in grids {
            grid.reloadData()
        }
    }
    
}
