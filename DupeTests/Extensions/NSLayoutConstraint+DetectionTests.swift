////
////  NSLayoutConstraintDetectionTest.swift
////  DupeTests
////
////  Created by Joshua James on 05.04.21.
////  Copyright © 2021 Cosmic. All rights reserved.
////
//
//import XCTest
//@testable import Dupe
//
//class NSLayoutConstraintDetectionTest: XCTestCase {
//    
//    let superview: UIView = UIView(frame: .zero)
//    let subview: UIView = UIView(frame: .zero)
//    
//    override func setUpWithError() throws {
//        subview.removeFromSuperview()
//        
//        for subview in superview.subviews {
//            subview.removeFromSuperview()
//        }
//    }
//    
////    func testIsTopConstraintWhereTopConstraintExists() {
////        superview.addSubviewWithConstraints(subview: subview,
////                                            atPosition: .)
////
////        let topConstraint = superview.constraints.getTopConstraint(forObject: subview)
////        let isTopConstraint = isATopConstraint(constraint: topConstraint)
////
////        XCTAssertTrue(isTopConstraint)
////    }
//    
//    func testIsTopConstraintWhereTopConstraintDoesNotExist() {
//        superview.addSubview(subview)
//        
//        let topConstraint = superview.constraints.getTopConstraint(forObject: subview)
//        let isTopConstraint = isATopConstraint(constraint: topConstraint)
//
//        XCTAssertFalse(isTopConstraint)
//    }
//    
//    func testXLayoutConstraintForLeftPosition() {
//        superview.addSubviewWithConstraints(subview: subview,
//                                            atPosition: .left)
//        
//        let xLayoutConstraint = NSLayoutConstraint.xLayoutConstraint(forSubview: subview,
//                                                                     forSuperview: superview,
//                                                                     forPosition: .left)
//        
//        let isLeftConstraint = xLayoutConstraint.firstAttribute == .leading || xLayoutConstraint.secondAttribute == .leading
//        
//        XCTAssertTrue(isLeftConstraint)
//    }
//    
//    func testXLayoutConstraintForCenterPosition() {
//        superview.addSubviewWithConstraints(subview: subview,
//                                            atPosition: .center)
//        
//        let xLayoutConstraint = NSLayoutConstraint.xLayoutConstraint(forSubview: subview,
//                                                                     forSuperview: superview,
//                                                                     forPosition: .center)
//        
//        let isCenterConstraint = xLayoutConstraint.firstAttribute == .centerX || xLayoutConstraint.secondAttribute == .centerX
//        
//        XCTAssertTrue(isCenterConstraint)
//    }
//    
//    func testXLayoutConstraintForRightPosition() {
//        superview.addSubviewWithConstraints(subview: subview,
//                                            atPosition: .right)
//        
//        let xLayoutConstraint = NSLayoutConstraint.xLayoutConstraint(forSubview: subview,
//                                                                     forSuperview: superview,
//                                                                     forPosition: .right)
//        
//        let isRightConstraint = xLayoutConstraint.firstAttribute == .trailing || xLayoutConstraint.secondAttribute == .trailing
//        
//        XCTAssertTrue(isRightConstraint)
//    }
//    
//    // MARK: - Helper -
//    
//    private func isATopConstraint(constraint: NSLayoutConstraint?) -> Bool {
//        return constraint?.firstAttribute == .top ||
//            constraint?.secondAttribute == .top
//    }
//
//}
