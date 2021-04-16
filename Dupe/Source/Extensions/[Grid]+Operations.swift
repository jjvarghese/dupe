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
        
        guard let position = grid.position else { return }
        
        let remainingGrids = grids(in: position)
        
        for remainingGrid in remainingGrids {
            remainingGrid.startFalling(withSharedGridSpace: remainingGrids.count - 1)
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
    
}
