//
//  [Grid]+Operations.swift
//  Dupe
//
//  Created by Joshua James on 03.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension Array where Element == Grid {
    
    mutating func removeAllGrids() {
        for grid in self {
            grid.removeFromSuperview()
        }
        
        removeAll()
    }
    
    mutating func remove(grid: Grid) {
        removeAll { (existingGrid) -> Bool in
            return grid == existingGrid
        }
        
        restackFallingGrids()
        
        if let position = grid.position {
            stack(in: position)
        }
    }
    
    
    
    func grids(in position: Position) -> [Grid] {
        var gridsOfPosition: [Grid] = []
        
        for grid in self {
            if grid.position == position {
                gridsOfPosition.append(grid)
            }
        }
        
        return gridsOfPosition
    }
    
    func numberOfGrids(in position: Position) -> Int {
        return grids(in: position).count
    }
    
    // MARK: - Private -
    
    private func stack(in position: Position) {
        DispatchQueue.main.async {
            let remainingGrids = grids(in: position)
            
            var i = 0
            for remainingGrid in remainingGrids {
                remainingGrid.startFalling(withSharedGridSpaceBelow: i)
                
                i = i + 1
            }
        }
    }
    
    private func restackFallingGrids() {
        DispatchQueue.main.async {
            let fallingGrids = falling()
            
            var i = 0
            for fallingGrid in fallingGrids {
                fallingGrid.descentInProgress = false
                fallingGrid.descentTimer?.invalidate()
                fallingGrid.descentTimer = nil
                
                fallingGrid.startFalling(withSharedGridSpaceBelow: i)
                
                i = i + 1
            }
        }
    }
    
    private func falling() -> [Grid] {
        var fallingGrids: [Grid] = []
        
        for grid in self {
            if grid.descentInProgress {
                fallingGrids.append(grid)
            }
        }
        
        return fallingGrids
    }
    
}
