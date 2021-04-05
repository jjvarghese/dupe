//
//  IntArrayOperationsExtensionTest.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class IntArrayOperationsExtensionTest: XCTestCase {
    
    func testToggleOnEmptyArray() {
        var array: [Int] = []
        
        array.toggle(element: 9)
        
        XCTAssertEqual([9], array)
    }
    
    func testToggleOnArrayWithMatchingElement() {
        var array: [Int] = [9]
        
        array.toggle(element: 9)
        
        XCTAssertEqual([], array)
    }
    
    func testToggleOnArrayWithNonMatchingElement() {
        var array: [Int] = [8]
        
        array.toggle(element: 9)
        
        XCTAssertEqual([8, 9], array)
    }
    
    func testAddIfNotAlreadyThereWithMatchingElement() {
        var array: [Int] = [9]
        
        array.addIfNotAlreadyThere(element: 9)
        
        XCTAssertEqual([9], array)
    }
    
    func testAddIfNotAlreadyThereWithNonMatchingElement() {
        var array: [Int] = [3]
        
        array.addIfNotAlreadyThere(element: 9)
        
        XCTAssertEqual([3, 9], array)
    }

}
