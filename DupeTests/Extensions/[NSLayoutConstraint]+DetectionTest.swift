//
//  NSLayoutConstraintArrayDetectionTests.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import XCTest
@testable import Dupe

class NSLayoutConstraintArrayDetectionTests: XCTestCase {
    
    func testGetTopConstraintWhereTopConstraintExists() {
        let superview: UIView = UIView(frame: .zero)
        let subview: UIView = UIView(frame: .zero)

        superview.addSubviewWithConstraints(subview: subview,
                                            atPosition: .center)
        
        let topConstraint = superview.constraints.getTopConstraint(forObject: subview)
        
        let isTopConstraint = topConstraint?.firstAttribute == .top || topConstraint?.secondAttribute == .top
        
        XCTAssertTrue(isTopConstraint)
    }
    
    func testGetTopConstraintWhereTopConstraintDoesNotExist() {
        let superview: UIView = UIView(frame: .zero)
        let subview: UIView = UIView(frame: .zero)

        superview.addSubview(subview)
        
        let topConstraint = superview.constraints.getTopConstraint(forObject: subview)
        
        XCTAssertNil(topConstraint)
    }

}
