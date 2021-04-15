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
                
                if collisionGridIndices.elementsEqual(gridIndices) {
                    self.triggerMatch(matchedGrid: grid)
                }
            }
        }
    }
    
    // MARK: - Private -
    
    private func triggerMatch(matchedGrid: Grid) {
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
            
            self.spawnExtraGridsIfDetermined()
            
            matchedGrid.removeFromSuperview()
            
            self.rotateColors()
        }
    }
        
    private func rotateColors() {
        UIColor.baseRubikColor = RubikColor.getRandomRubikColor()
        
        let collisionGrid = delegate.gameSessionRequestsCollisionGrid(self)
        
        collisionGrid?.reloadData()
        
        for grid in grids {
            grid.reloadData()
        }
    }
    
}
