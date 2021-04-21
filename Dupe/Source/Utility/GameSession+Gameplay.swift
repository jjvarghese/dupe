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
    
    func checkForMatch() {
        guard let collisionGrid = delegate.gameSessionRequestsCollisionGrid(self) else { return }
                     
        let collisionGridIndices = collisionGrid.selectedIndices.sorted()
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            for grid in self.grids {
                let gridIndices = grid.selectedIndices.sorted()
                
                if collisionGridIndices.elementsEqual(gridIndices) && collisionGrid.rubikColor == grid.rubikColor {
                    self.triggerMatch(matchedGrid: grid)
                }
            }
        }
    }
    
    func triggerGameOver(withCompletion completion:@escaping () -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.grids.removeAllGrids()

            let collisionGrid = self.delegate.gameSessionRequestsCollisionGrid(self)
            
            collisionGrid?.reset()
            
            completion()
        }
    }
    
    // MARK: - Private -
    
    private func triggerMatch(matchedGrid: Grid) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
                        
            let collisionGrid = self.delegate.gameSessionRequestsCollisionGrid(self)
            
            collisionGrid?.reset()
            
            self.grids.remove(grid: matchedGrid)
                        
            let numberOfPointsToGain = self.getNumberOfPointsToGain(matchedGrid: matchedGrid)
            
            self.delegate.gameSessionTriggersMatch(self,
                                                   withGainedScore: numberOfPointsToGain)
            
            self.currentScore += numberOfPointsToGain
        }
    }
    
}
