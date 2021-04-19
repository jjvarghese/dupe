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
    
    func spawnGrid() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.currentSpawnSpeed > Constants.Values.minimumSpawnTime {
                self.currentSpawnSpeed = self.currentSpawnSpeed - Constants.Values.spawnTimeReduction
            }
            
            let position = Position.random()
                                    
            let grid = self.generateNewGrid(in: position)
                                             
            let numExistingGrids = self.grids.numberOfGrids(in: position)
            
            if numExistingGrids > 5 {
                self.triggerGameOver { [weak self] in
                    guard let self = self else { return }
                    
                    self.delegate.gameSessionTriggersGameOver(self)
                }
                
                return
            }
            
            grid.descend()
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + self.currentSpawnSpeed) { [weak self] in
//                self?.spawnGrid()
//            }
        }
    }
    
    // MARK: - Private -
    
    private func generateNewGrid(in position: Position) -> Grid {
        let grid = Grid(withGriddable: delegate)
        
        grid.position = position
        
        grids.add(grid: grid)
        
        delegate.view.addSubviewWithConstraints(subview: grid,
                                                atPosition: position)
        
        grid.randomise()
        grid.accessibilityIdentifier = "SmallGrid"
        
        return grid
    }
    
}
