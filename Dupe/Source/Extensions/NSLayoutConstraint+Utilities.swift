//
//  NSLayoutConstraint+ConstraintDetection.swift
//  Dupe
//
//  Created by Joshua James on 21.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    func isTopConstraint(forObject object: AnyObject) -> Bool {
        guard let firstItem = firstItem,
              let secondItem = secondItem else { return false }
        
        return (firstItem.isEqual(object) && firstAttribute == .top) || (secondItem.isEqual(object) && secondAttribute == .top)
    }
    
    static func xLayoutConstraint(forSubview subview: UIView,
                                  forSuperview superview: UIView,
                                  forPosition position: Position) -> NSLayoutConstraint {
        if position == .innerLeft || position == .outerLeft {
            return NSLayoutConstraint(item: subview,
                                       attribute: .leading,
                                       relatedBy: .equal,
                                       toItem: superview,
                                       attribute: .leading,
                                       multiplier: 1,
                                       constant: (superview.frame.width / 5) - position.getXPositionOffset())
        } else {
            return NSLayoutConstraint(item: subview,
                                       attribute: .trailing,
                                       relatedBy: .equal,
                                       toItem: superview,
                                       attribute: .trailing,
                                       multiplier: 1,
                                       constant: -(superview.frame.width / 5) - position.getXPositionOffset())
        }
    }
    
    static func centerConstraint(forSubview subview: UIView,
                                    forSuperview superview: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: subview,
                                  attribute: .centerX,
                                  relatedBy: .equal,
                                  toItem: superview,
                                  attribute: .centerX,
                                  multiplier: 1,
                                  constant: 0)
    }
    
    static func topConstraint(forSubview subview: UIView,
                              forSuperview superview: UIView,
                              withOffset offset: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: subview,
                                  attribute: .top,
                                  relatedBy: .equal,
                                  toItem: superview,
                                  attribute: .top,
                                  multiplier: 1,
                                  constant: offset)
    }
    
    static func widthConstraint(forSubview subview: UIView,
                              forSuperview superview: UIView,
                              withOffset offset: CGFloat = 0,
                              withStaticWidth width: CGFloat? = nil) -> NSLayoutConstraint {
        if let width = width {
            return NSLayoutConstraint(item: subview,
                                      attribute: .width,
                                      relatedBy: .equal,
                                      toItem: nil,
                                      attribute: .notAnAttribute,
                                      multiplier: 1,
                                      constant: width)
        } else {
            return NSLayoutConstraint(item: subview,
                                      attribute: .width,
                                      relatedBy: .equal,
                                      toItem: superview,
                                      attribute: .width,
                                      multiplier: 1,
                                      constant: offset)
        }
       
    }
    
    static func heightConstraint(forSubview subview: UIView,
                              forSuperview superview: UIView,
                              withOffset offset: CGFloat = 0,
                              withStaticHeight height: CGFloat? = nil) -> NSLayoutConstraint {
        if let height = height {
            return NSLayoutConstraint(item: subview,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1,
                               constant: height)
        } else {
            return NSLayoutConstraint(item: subview,
                                      attribute: .height,
                                      relatedBy: .equal,
                                      toItem: superview,
                                      attribute: .height,
                                      multiplier: 1,
                                      constant: offset)
        }
    }
    
}
