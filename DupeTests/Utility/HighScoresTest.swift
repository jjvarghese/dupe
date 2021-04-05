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

    func testSaveAndReadAScore() throws {
        let score = 9999
        
        HighScores.save(score: score,
                        storage: testableStorage)
        
        let storedScores = HighScores.getScores(storage: testableStorage)
        
        XCTAssert(storedScores.count == 1)
        
        let retrievedScore = storedScores.first
        
        XCTAssertEqual(retrievedScore, score)
    }
    
    func testSaveMoreThanMaxAmountOfScores() throws {
        let scores = [1, 2, 3, 4, 5, 6]
        
        for score in scores {
            HighScores.save(score: score,
                            storage: testableStorage)
        }
        
        let storedScores = HighScores.getScores(storage: testableStorage)

        XCTAssert(storedScores.count == 5)
    }
    
    func testOrderingOfMultipleScores() throws {
        let scores = [1, 3, 2, 5, 4, 6]
        
        for score in scores {
            HighScores.save(score: score,
                            storage: testableStorage)
        }
        
        let storedScores = HighScores.getScores(storage: testableStorage)
        
        XCTAssertEqual([6, 5, 4, 3, 2], storedScores)
    }
    
    func testEmptyArrayWhenNoScores() throws {
        let storedScores = HighScores.getScores(storage: testableStorage)

        XCTAssertEqual([], storedScores)
    }
    
    // MARK: - Helper -
    
    private func deleteExistingStorage() {
        testableStorage.set(object: nil,
                            forKey: Constants.Keys.highScores)
    }

}
