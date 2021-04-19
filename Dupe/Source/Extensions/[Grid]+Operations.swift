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
    
//    private func restack() {
//        DispatchQueue.main.async {
//            var i = 0
//            for grid in self {
//                grid.descentInProgress = false
//                grid.descentTimer?.invalidate()
//                grid.descentTimer = nil
//                grid.startFalling(withSharedGridSpaceBelow: i)
//
//                i = i + 1
//            }
//        }
//    }
//
//    private func falling() -> [Grid] {
//        var fallingGrids: [Grid] = []
//
//        for grid in self {
//            if grid.descentInProgress {
//                fallingGrids.append(grid)
//            }
//        }
//
//        return fallingGrids
//    }
//
}
