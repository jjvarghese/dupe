//
//  MenuOptionTextTest.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class MenuOptionTextTest: XCTestCase {
    
    func testCorrectTitleForAbout() {
        let text = MenuOption.about.title()
        
        XCTAssertEqual(Constants.Menu.about, text)
    }
    
    func testCorrectTitleForScore() {
        let text = MenuOption.highScores.title()
        
        XCTAssertEqual(Constants.Menu.highScores, text)
    }
    
    func testCorrectTitleForStart() {
        let text = MenuOption.start.title()
        
        XCTAssertEqual(Constants.Menu.start, text)
    }

}
