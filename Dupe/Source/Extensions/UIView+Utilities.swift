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
    
    func addWrappedSubview(subview: UIView) {
        addSubviewAndRemoveAutotranslation(subview: subview)
        
        let centerConstraint = NSLayoutConstraint.centerConstraint(forSubview: subview,
                                                                   forSuperview: self)
        
        let topConstraint = NSLayoutConstraint.topConstraint(forSubview: subview,
                                                             forSuperview: self)
        
        let widthConstraint = NSLayoutConstraint.widthConstraint(forSubview: subview,
                                                                 forSuperview: self)
        
        let heightConstraint = NSLayoutConstraint.heightConstraint(forSubview: subview,
                                                                   forSuperview: self)
        
        addConstraints([centerConstraint,
                        topConstraint,
                        widthConstraint,
                        heightConstraint])
    }
    
    func addSubviewWithConstraints(subview: UIView,
                                   atPosition position: Position,
                                   withWidth width: CGFloat? = nil,
                                   withHeight height: CGFloat? = nil,
                                   withVerticalOffset verticalOffset: CGFloat = Constants.Values.gridStartPosition) {
        addSubviewAndRemoveAutotranslation(subview: subview)
        
        let xConstraint = NSLayoutConstraint.xLayoutConstraint(forSubview: subview,
                                                               forSuperview: self,
                                                               forPosition: position)
        let topConstraint = NSLayoutConstraint.topConstraint(forSubview: subview,
                                                             forSuperview: self,
                                                             withOffset: verticalOffset)
        
        
        let widthConstraint = NSLayoutConstraint.widthConstraint(forSubview: subview,
                                                                 forSuperview: self,
                                                                 withStaticWidth: width)
        
        let heightConstraint = NSLayoutConstraint.heightConstraint(forSubview: subview,
                                                                   forSuperview: self,
                                                                   withStaticHeight: height)
        
        if verticalOffset == Constants.Values.gridStartPosition {
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
    
    // MARK: - Private -
    
    private func addSubviewAndRemoveAutotranslation(subview: UIView) {
        addSubview(subview)
        
        subview.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
