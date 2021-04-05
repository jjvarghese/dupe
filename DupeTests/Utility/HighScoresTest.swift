//
//  HighScoresTest.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class HighScoresTest: XCTestCase {

    private var testableStorage: TestableStorage = TestableStorage()
    
    override func setUpWithError() throws {
        deleteExistingStorage()
    }

    override func tearDownWithError() throws {
    }

    func testSaveAndReadAScore() throws {
        let score = 9999
        
        HighScores.save(score: score,
                        storage: testableStorage)
        
        let storedScores = HighScores.getScores(storage: testableStorage)
        
        XCTAssert(storedScores.count == 1)
        
        let retrievedScore = storedScores.first
        
        XCTAssertEqual(retrievedScore, score)
    }
    
    // MARK: - Helper -
    
    private func deleteExistingStorage() {
        testableStorage.set(object: nil,
                            forKey: "HIGH_SCORES")
        // TODO: Make keys global
    }

}
