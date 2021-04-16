//
//  UIView+Utilities.swift
//  Dupe
//
//  Created by Joshua James on 24.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviewWithConstraints(subview: UIView,
                                   atPosition position: Position,
                                   withWidth width: CGFloat? = nil,
                                   withHeight height: CGFloat? = nil,
                                   withVerticalOffset verticalOffset: CGFloat = Grid.START_POSITION) {
        addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let xConstraint: NSLayoutConstraint = NSLayoutConstraint.xLayoutConstraint(forSubview: subview,
                                                                                   forSuperview: self,
                                                                                   forPosition: position)
        let topConstraint = NSLayoutConstraint(item: subview,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: self,
                                               attribute: NSLayoutConstraint.Attribute.top,
                                               multiplier: 1,
                                               constant: verticalOffset)
        let widthConstraint = NSLayoutConstraint(item: subview,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: width ?? frame.size.height / 5)
        let heightConstraint = NSLayoutConstraint(item: subview,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height ?? frame.size.height / 5)
        
        if verticalOffset == Grid.START_POSITION {
            addConstraints([xConstraint,
                            widthConstraint,
                            heightConstraint])
            
            NSLayoutConstraint.activate([subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)])
        } else {
            addConstraints([xConstraint,
                            topConstraint,
                            widthConstraint,
                            heightConstraint])
        }
    }
    
    func removeAllExistingGestureRecognizers() {
        if let gestureRecognizers = gestureRecognizers {
            for existingRecognizer in gestureRecognizers {
                removeGestureRecognizer(existingRecognizer)
            }
        }
    }
    
}
