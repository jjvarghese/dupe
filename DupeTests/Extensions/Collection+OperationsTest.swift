//
//  CollectionOperationTests.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class CollectionOperationTests: XCTestCase {
    
    func testSafeIndexRetrievalForNilCase() {
        let collection = ["a", "b", "c"]
        
        let safelyRetrievedIndex = collection[safe: 5]
        
        XCTAssertNil(safelyRetrievedIndex)
    }
    
    func testSafeIndexRetrievalForNonNilCase() {
        let collection = ["a", "b", "c"]
        
        let safelyRetrievedIndex = collection[safe: 1]
        
        XCTAssertEqual("b", safelyRetrievedIndex)
    }

}
