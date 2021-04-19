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
            grids(in: position).restack()
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
    
//    func restackIfNeeded() {
//        var i = 0
//        for grid in self {
//            guard !grid.descentInProgress else { continue }
//
//            let gridBottom = grid.frame.origin.y + grid.frame.size.height
//
//            if let nextGrid = self[safe: i + 1] {
//                let nextGridTop = nextGrid.frame.origin.y + grid.frame.size.height
//
//                if gridBottom - nextGridTop != 0 {
//                    grid.startFalling(withSharedGridSpaceBelow: i)
//                }
//            } else {
//                let bottomOfScreen = UIApplication.topViewController()?.view.frame.size.height ?? 0
//
//                if gridBottom - bottomOfScreen != 0 {
//                    grid.startFalling(withSharedGridSpaceBelow: i)
//                }
//            }
//
//            i = i + 1
//        }
//    }
    
    // MARK: - Private -
    
    private func restack() {
        DispatchQueue.main.async {
            var i = 0
            for grid in self {
                grid.descentInProgress = false
                grid.descentTimer?.invalidate()
                grid.descentTimer = nil
                grid.startFalling(withSharedGridSpaceBelow: i)
                
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
