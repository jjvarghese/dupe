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
        var grids: [Grid] = [Grid(withSize: .small),
                             Grid(withSize: .small),
                             Grid(withSize: .small)]
        
        grids.removeAllGrids()
        
        XCTAssertEqual([], grids)
    }
    
    func testRemoveFromSuperviewOnRemoveAllGrids() {
        let superview: UIView = UIView(frame: .zero)
        
        let grid1 = Grid(withSize: .small)
        let grid2 = Grid(withSize: .small)
        let grid3 = Grid(withSize: .small)
        
        superview.addSubview(grid1)
        superview.addSubview(grid2)
        superview.addSubview(grid3)
        
        var grids: [Grid] = [grid1, grid2, grid3]
        
        grids.removeAllGrids()
        
        XCTAssertEqual(superview.subviews, [])
    }

}
