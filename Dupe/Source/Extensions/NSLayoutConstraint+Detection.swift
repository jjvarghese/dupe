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
        switch position {
        case .left:
            return getLeftConstraint(forSubview: subview,
                                     forSuperview: superview)
        case .right:
            return getRightConstraint(forSubview: subview,
                                      forSuperview: superview)
        case .center:
            return getCentreConstraint(forSubview: subview,
                                              forSuperview: superview)
        }
    }
    
    // MARK: - Private -
    
    private static let LEFT_CONSTANT: CGFloat = 14
    private static let RIGHT_CONSTANT: CGFloat = -14
    
    private static func getLeftConstraint(forSubview subview: UIView,
                                     forSuperview superview: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: subview,
                                   attribute: NSLayoutConstraint.Attribute.leading,
                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                   toItem: superview,
                                   attribute: NSLayoutConstraint.Attribute.leading,
                                   multiplier: 1,
                                   constant: (superview.frame.width / 5) - LEFT_CONSTANT)
    }
    
    private static func getCentreConstraint(forSubview subview: UIView,
                                       forSuperview superview: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: subview,
                                   attribute: NSLayoutConstraint.Attribute.centerX,
                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                   toItem: superview,
                                   attribute: NSLayoutConstraint.Attribute.centerX,
                                   multiplier: 1,
                                   constant: 0)
    }
    
    private static func getRightConstraint(forSubview subview: UIView,
                                      forSuperview superview: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: subview,
                                   attribute: NSLayoutConstraint.Attribute.trailing,
                                   relatedBy: NSLayoutConstraint.Relation.equal,
                                   toItem: superview,
                                   attribute: NSLayoutConstraint.Attribute.trailing,
                                   multiplier: 1,
                                   constant: -(superview.frame.width / 5) - RIGHT_CONSTANT)
    }
    
}
