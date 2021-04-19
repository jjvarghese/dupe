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
                        
            let position = Position.random()
            
            guard !self.checkPositionForGameOver(in: position) else { return }
            guard !self.grids.previousGridIsInTheWay(in: position) else {
                self.respawn()
                
                return
            }
            
            if self.currentSpawnSpeed > Constants.Values.minimumSpawnTime {
                self.currentSpawnSpeed = self.currentSpawnSpeed - Constants.Values.spawnTimeReduction
            }
            
            self.generateNewGrid(in: position)
            self.respawn()
        }
    }
    
    // MARK: - Private -
    
    private func respawn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + self.currentSpawnSpeed) { [weak self] in
            self?.spawnGrid()
        }
    }
    
    private func checkPositionForGameOver(in position: Position) -> Bool {
        let numberOfExistingGrids = self.grids.numberOfGrids(in: position)
        
        if numberOfExistingGrids > (Constants.Values.maxNumberOfGridStacks - 1) {
            self.triggerGameOver { [weak self] in
                guard let self = self else { return }
                
                self.delegate.gameSessionTriggersGameOver(self)
            }
            
            return true
        } else {
            return false
        }
    }
    
    private func generateNewGrid(in position: Position) {
        let grid = Grid(withGriddable: delegate)
        
        grid.position = position
        
        grids.add(grid: grid)
        
        delegate.view.addSubviewWithConstraints(subview: grid,
                                                atPosition: position)
        
        grid.randomise()
        grid.accessibilityIdentifier = "SmallGrid"
    }
    
}
