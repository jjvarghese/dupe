//
//  DupeUITests.swift
//  DupeUITests
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import XCTest

class DupeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

      
    }

    override func tearDownWithError() throws {
      
    }

    func testHitAbout() throws {
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
