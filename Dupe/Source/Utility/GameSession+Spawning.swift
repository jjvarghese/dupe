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
    
    func startSpawning() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.spawnTimer = Timer.scheduledTimer(timeInterval: self.spawnTime,
                                 target: self,
                                 selector: #selector(self.spawnGrid),
                                 userInfo: nil,
                                 repeats: true)
        }
    }

    // MARK: - Private -
    
    @objc func spawnGrid() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.spawnTime -= 0.1
            
            let position = Position.random()
            
//            for grid in self.grids {
//                if grid.position == position && grid.descentInProgress {
//                    return
//                }
//            }
                                    
            let grid = self.generateNewGrid(in: position)
                                             
            let numExistingGrids = self.grids.numberOfGrids(in: position)
            
            grid.startFalling(withSharedGridSpaceBelow: numExistingGrids - 1)
        }
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
    
}
