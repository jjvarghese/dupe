//
//  GridArrayOperationsTest.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class GridArrayOperationsTest: XCTestCase {
    
    func testRemoveAllGrids() {
        var grids: [Grid] = [Grid(frame: .zero),
                             Grid(frame: .zero),
                             Grid(frame: .zero)]
        
        grids.removeAllGrids()
        
        XCTAssertEqual([], grids)
    }
    
    func testRemoveFromSuperviewOnRemoveAllGrids() {
        let superview: UIView = UIView(frame: .zero)
        
        let grid1 = Grid(frame: .zero)
        let grid2 = Grid(frame: .zero)
        let grid3 = Grid(frame: .zero)
        
        superview.addSubview(grid1)
        superview.addSubview(grid2)
        superview.addSubview(grid3)
        
        var grids: [Grid] = [grid1, grid2, grid3]
        
        grids.removeAllGrids()
        
        XCTAssertEqual(superview.subviews, [])
    }

}
