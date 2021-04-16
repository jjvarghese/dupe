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
                                       attribute: NSLayoutConstraint.Attribute.leading,
                                       relatedBy: NSLayoutConstraint.Relation.equal,
                                       toItem: superview,
                                       attribute: NSLayoutConstraint.Attribute.leading,
                                       multiplier: 1,
                                       constant: (superview.frame.width / 5) - position.getXPositionOffset())
        } else {
            return NSLayoutConstraint(item: subview,
                                       attribute: NSLayoutConstraint.Attribute.trailing,
                                       relatedBy: NSLayoutConstraint.Relation.equal,
                                       toItem: superview,
                                       attribute: NSLayoutConstraint.Attribute.trailing,
                                       multiplier: 1,
                                       constant: -(superview.frame.width / 5) - position.getXPositionOffset())
        }
        
    }
    
}
