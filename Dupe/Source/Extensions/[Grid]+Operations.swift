//
//  [Grid]+Operations.swift
//  Dupe
//
//  Created by Joshua James on 03.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

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
        
        grid.animate(withAnimation: .zoomOut) {
            grid.removeFromSuperview()
        }
  
        if let position = grid.position {
           updateStackRanks(in: position)
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
    
    mutating func add(grid: Grid) {
        append(grid)
        
        guard let position = grid.position else { return }
        
        updateStackRanks(in: position)
    }
    
    func previousGridIsInTheWay(in position: Position) -> Bool {
        if let previousGridInStack = grids(in: position).last {
            let previousGridSpot = previousGridInStack.frame.origin.y + Constants.Values.gridOverlapBuffer
            let newGridSpace = Constants.Values.gridStartPosition + previousGridInStack.frame.size.height
            
            return previousGridSpot < newGridSpace
        } else {
            return false
        }
    }

    // MARK: - Private -
    
    private func updateStackRanks(in position: Position) {
        var i = 0
        
        for grid in grids(in: position) {
            if let stackRank = StackRank(rawValue: i) {
                grid.stackRank = stackRank
            }
            
            i = i + 1
        }
    }
    
}
