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
            guard let self = self else { return }
            
            for grid in self.grids {
                if grid.position == position && grid.descentInProgress {
                    return
                }
            }
                                    
            let grid = self.generateNewGrid(in: position)
            
            self.increaseTempoIfNeeded()
                                 
            let numExistingGrids = self.grids.numberOfGrids(in: position)
            
            grid.startFalling(withTempo: self.tempo,
                              withSharedGridSpace: numExistingGrids - 1)
        }
    }
    
    func spawnExtraGridsIfDetermined() {
        Timer.scheduledTimer(timeInterval: Constants.Values.sideGridSpawnDelay,
                             target: self,
                             selector: #selector(self.spawnRandomGrid),
                             userInfo: nil,
                             repeats: false)
    }
    
    // MARK: - Private -
    
    @objc private func spawnRandomGrid() {
        spawnGrid(in: Position.random())
    }
    
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
