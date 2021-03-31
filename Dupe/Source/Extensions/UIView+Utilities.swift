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
                                   withWidth width: CGFloat = 60,
                                   withHeight height: CGFloat = 60) {
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
                                               multiplier: Grid.START_POSITION,
                                               constant: 0)
        let widthConstraint = NSLayoutConstraint(item: subview,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: width)
        let heightConstraint = NSLayoutConstraint(item: subview,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height)
        
        addConstraints([xConstraint,
                        topConstraint,
                        widthConstraint,
                        heightConstraint])
    }
    
    func removeAllExistingGestureRecognizers() {
        if let gestureRecognizers = gestureRecognizers {
            for existingRecognizer in gestureRecognizers {
                removeGestureRecognizer(existingRecognizer)
            }
        }
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide,
                   withColor color: CGColor,
                   andThickness thickness: CGFloat) {
        let border = CALayer()
        
        border.backgroundColor = color
        
        switch side {
        case .Left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
    
}
