//
//  DupeUITests.swift
//  DupeUITests
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class DupeUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

      
    }

    override func tearDownWithError() throws {
      
    }

//    func testPlay() throws {
//        let app = XCUIApplication()
//        
//        app.launch()
//                
//        app.buttons["START"].tap()
//        app.collectionViews["SmallGrid"].waitForExistence(timeout: 5)
//        app.otherElements["0"].tap()
//        app.otherElements["1"].tap()
//        app.otherElements["2"].tap()
//
//    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
