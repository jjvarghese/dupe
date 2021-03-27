//
//  UILabel+Utilities.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    static func spawnFloatingFadingLabel(toSuperview superview: UIView,
                                         withText text: String,
                                  withCompletion completion: (() -> Void)? = nil) {
        let label: UILabel = UILabel(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: superview.frame.size.width,
                                                    height: 50))
        label.center = superview.center
        label.text = text
        label.theme()
        
        superview.addSubview(label)
        
        let duration = 0.75
        
        label.floatUp(for: duration)
        label.fadeOut(for: duration)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            label.removeFromSuperview()
            
            completion?()
        }
    }
    
    static func spawnFloatingFadingLabels(toSuperview superview: UIView,
                                          withTexts texts: [String],
                                   withCompletion finalCompletion: (() -> Void)?) {
        guard texts.count > 0 else {
            finalCompletion?()
            
            return
        }
        
        var remainingTexts = texts
        
        let firstText = remainingTexts.removeFirst()
                    
        UILabel.spawnFloatingFadingLabel(toSuperview: superview,
                                         withText: firstText,
                                 withCompletion: {
                                    UILabel.spawnFloatingFadingLabels(toSuperview: superview,
                                                                      withTexts: remainingTexts,
                                                                      withCompletion: finalCompletion)
        })
    }
    
}
