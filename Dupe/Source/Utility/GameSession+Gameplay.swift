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
            
            UILabel.spawnFloatingFadingLabel(toSuperview: self.delegate.view,
                                             withText: Constants.Text.collisionText)
            
            completion()
        }
    }
    
    // MARK: - Private -
    
    private func triggerMatch(matchedGrid: Grid) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.delegate.gameSessionTriggersMatch(self)
            
            let collisionGrid = self.delegate.gameSessionRequestsCollisionGrid(self)
            
            collisionGrid?.reset()
            
            self.grids.remove(grid: matchedGrid)
            
            self.spawnGrid(in: Position.random())
            
            let numberOfPointsToGain = self.getNumberOfPointsToGain(matchedGrid: matchedGrid)
            
            UILabel.spawnFloatingFadingLabel(toSuperview: self.delegate.view,
                                             withText: String(format: "%d", numberOfPointsToGain))
            
            self.currentScore += numberOfPointsToGain
            
            self.spawnExtraGridsIfDetermined()
            
            matchedGrid.removeFromSuperview()
        }
    }
    
}
