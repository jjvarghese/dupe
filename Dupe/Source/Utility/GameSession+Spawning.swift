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
                        
            let grid = Grid(withGriddable: self.delegate)
            
            grid.position = position
            
            self.grids.append(grid)
            
            self.delegate.view.addSubviewWithConstraints(subview: grid,
                                                atPosition: position)
            
            grid.randomise()
            grid.accessibilityIdentifier = "SmallGrid"
            
            if self.tempo > Constants.Values.DifficultyThreshold.getMaximumTempo(forCurrentScore: self.currentScore) { // Maximum speed
                self.tempo -= Constants.Values.incrementTempo
            }
                        
            let threshold = position == .center ? 0.0 : 0.01
            
            grid.startFalling(collisionGrid: collisionGrid,
                              withTempo: self.tempo + threshold)
        }
    }
    
}
