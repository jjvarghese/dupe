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
    }
    
}
