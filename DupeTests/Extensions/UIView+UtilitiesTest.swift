//
//  UIViewUtilitiesTest.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class UIViewUtilitiesTest: XCTestCase {
    
    let superview = UIView(frame: .zero)
    let subview = UIView(frame: .zero)
    
    override func setUpWithError() throws {
        subview.removeFromSuperview()
        
        for subview in superview.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func testAddSubviewWithConstraintsHasCorrectSubview() {
        superview.addSubviewWithConstraints(subview: subview,
                                            atPosition: .center)
        
        let containsSubview: Bool = superview.subviews.contains { (element) -> Bool in
            return element == subview
        }
        
        XCTAssertTrue(containsSubview)
    }
    
    func testSubviewTranslatesAutoresizingMaskIntoConstraintsDisabled() {
        superview.addSubviewWithConstraints(subview: subview,
                                            atPosition: .center)
        
        XCTAssertFalse(subview.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testRemoveAllExistingGestureRecognizers() {
        let view = UIView(frame: .zero)
        
        let gestureRecognizer1 = UIGestureRecognizer(target: nil, action: nil)
        let gestureRecognizer2 = UIGestureRecognizer(target: nil, action: nil)
        let gestureRecognizer3 = UIGestureRecognizer(target: nil, action: nil)
        
        view.addGestureRecognizer(gestureRecognizer1)
        view.addGestureRecognizer(gestureRecognizer2)
        view.addGestureRecognizer(gestureRecognizer3)
        
        view.removeAllExistingGestureRecognizers()
        
        XCTAssertEqual([], view.gestureRecognizers)
    }
    
    func testRemoveAllExistingGestureRecognizersWithNoRecognizers() {
        let view = UIView(frame: .zero)

        view.removeAllExistingGestureRecognizers()

        XCTAssertNil(view.gestureRecognizers)
    }

}
