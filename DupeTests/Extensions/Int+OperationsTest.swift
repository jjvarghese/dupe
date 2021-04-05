//
//  IntOperationsTest.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class IntOperationsTest: XCTestCase {
    
    func testSmoothPathsForIndex0() {
        let index = 0
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([4, 1], paths)
    }
    
    func testSmoothPathsForIndex1() {
        let index = 1
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([0, 5, 2], paths)
    }
    
    func testSmoothPathsForIndex2() {
        let index = 2
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([1, 6, 3], paths)
    }
    
    func testSmoothPathsForIndex3() {
        let index = 3
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([2, 7], paths)
    }
    
    func testSmoothPathsForIndex4() {
        let index = 4
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([0, 5, 8], paths)
    }
    
    func testSmoothPathsForIndex5() {
        let index = 5
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([1, 6, 9, 4], paths)
    }
    
    func testSmoothPathsForIndex6() {
        let index = 6
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([2, 10, 5, 7], paths)
    }
    
    func testSmoothPathsForIndex7() {
        let index = 7
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([3, 6, 11], paths)
    }
    
    func testSmoothPathsForIndex8() {
        let index = 8
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([4, 9, 12], paths)
    }
    
    func testSmoothPathsForIndex9() {
        let index = 9
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([5, 8, 13, 10], paths)
    }
    
    func testSmoothPathsForIndex10() {
        let index = 10
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([6, 9, 14, 11], paths)
    }
    
    func testSmoothPathsForIndex11() {
        let index = 11
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([7, 10, 15], paths)
    }
    
    func testSmoothPathsForIndex12() {
        let index = 12
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([8, 13], paths)
    }
    
    func testSmoothPathsForIndex13() {
        let index = 13
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([12, 9, 14], paths)
    }
    
    func testSmoothPathsForIndex14() {
        let index = 14
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([13, 10, 15], paths)
    }
    
    func testSmoothPathsForIndex15() {
        let index = 15
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([14, 11], paths)
    }
    
    func testSmoothPathsForOutOfRangeIndex() {
        let index = 16
        let paths = index.getSmoothPathsForSize16Grid()
        
        XCTAssertEqual([], paths)
    }

}

