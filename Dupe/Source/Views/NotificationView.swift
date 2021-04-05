//
//  AboutView.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit
import SwiftEntryKit

class NotificationView: UIView {
            
    @IBOutlet private weak var blCorner: UIView?
    @IBOutlet private weak var brCorner: UIView?
    @IBOutlet private weak var textView: UITextView?
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureSubviews()
    }
    
    // MARK: - Methods -
    
    func popin(withText text: String) {
        var attributes = EKAttributes()
        
        attributes.name = "NotificationView"
        attributes.windowLevel = .normal
        attributes.displayDuration = .infinity
        
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.9)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
        
        attributes.positionConstraints.size = .init(width: widthConstraint,
                                                    height: heightConstraint)
        attributes.entryInteraction = .dismiss
        attributes.screenInteraction = .dismiss
        attributes.statusBar = .hidden
        
        if UIDevice.current.hasNotch {
            attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
            
            if let baseRgb = GameViewController.baseRubikColor.rgb() {
                let baseEKColor = EKColor(rgb: baseRgb)

                attributes.entryBackground = .color(color: baseEKColor)
            }
        } else {
            attributes.positionConstraints.safeArea = .overridden
        }
                        
        SwiftEntryKit.display(entry: self, using: attributes)
        
        textView?.text = text
        
        textView?.backgroundColor = GameViewController.baseRubikColor
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureTextViews()
        configureCorners()
    }
    
    private func configureTextViews() {
        textView?.theme()
        textView?.backgroundColor = GameViewController.baseRubikColor
    }
    
    private func configureCorners() {
        blCorner?.backgroundColor = UIColor.background
        brCorner?.backgroundColor = UIColor.background
    }
    
}
