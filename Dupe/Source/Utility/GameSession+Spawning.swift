//
//  GameSession+Spawning.swift
//  Dupe
//
//  Created by Joshua James on 15.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameSession {
    
    func spawnGrid(in position: Position) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let collisionGrid = self.delegate.gameSessionRequestsCollisionGrid(self) else { return }
            
            for grid in self.grids {
                if grid.position == position {
                    return
                }
            }
                        
            let grid = self.generateNewGrid(in: position)
            
            self.increaseTempoIfNeeded()
                        
            let threshold = position == .center ? 0.0 : 0.01
            
            grid.startFalling(collisionGrid: collisionGrid,
                              withTempo: self.tempo + threshold)
        }
    }
    
    @objc func spawnSideGrid() {
        var hasExistingLeftGrid = false
        var hasExistingRightGrid = false
        
        for grid in grids {
            if grid.position == .left {
                hasExistingLeftGrid = true
            } else if grid.position == .right {
                hasExistingRightGrid = true
            }
        }
        
        if hasExistingRightGrid && hasExistingLeftGrid {
            return
        } else if hasExistingRightGrid {
            spawnGrid(in: .left)
        } else if hasExistingLeftGrid {
            spawnGrid(in: .right)
        } else {
            let coinFlip = Int.random(in: 0..<2)
            
            spawnGrid(in: coinFlip == 0 ? .left : .right)
        }
    }
    
    // MARK: - Private -
    
    private func generateNewGrid(in position: Position) -> Grid {
        let grid = Grid(withGriddable: delegate)
        
        grid.position = position
        
        grids.append(grid)
        
        delegate.view.addSubviewWithConstraints(subview: grid,
                                                atPosition: position)
        
        grid.randomise()
        grid.accessibilityIdentifier = "SmallGrid"
        
        return grid
    }
    
    private func increaseTempoIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.tempo > Constants.Values.DifficultyThreshold.getMaximumTempo(forCurrentScore: self.currentScore) { // Maximum speed
                self.tempo -= Constants.Values.incrementTempo
            }
        }
        
    }
}
