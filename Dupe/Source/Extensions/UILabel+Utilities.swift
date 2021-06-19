//
//  UILabel+Utilities.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit
import Spring

extension UILabel {
    
    static func spawnFloatingFadingLabel(toSuperview superview: UIView,
                                         withFrame frame: CGRect? = nil,
                                         withColor color: UIColor? = nil,
                                         withText text: String,
                                  withCompletion completion: (() -> Void)? = nil) {
        let label: SpringLabel = SpringLabel(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: superview.frame.size.width,
                                                    height: 50))
        if let frame = frame {
            label.frame.origin = frame.origin
            label.frame.size = CGSize(width: frame.size.width,
                                      height: 50)
            label.frame.origin.y += frame.size.height / 2
        } else {
            label.center = superview.center
            label.frame.origin.y = 10
        }
        
        label.text = text
        label.theme(withColor: color)
        
        superview.addSubview(label)
        
        let duration = 0.75
        
        label.floatUp(for: duration)
        label.fade(out: true, for: duration)
        label.animate(withAnimation: .Swing)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            label.removeFromSuperview()
            
            completion?()
        }
    }
    
    static func spawnFloatingFadingLabels(toSuperview superview: UIView,
                                          withFrame frame: CGRect? = nil,
                                          withColor color: UIColor? = nil,
                                          withTexts texts: [String],
                                   withCompletion finalCompletion: (() -> Void)?) {
        guard texts.count > 0 else {
            finalCompletion?()
            
            return
        }
        
        var remainingTexts = texts
        
        let firstText = remainingTexts.removeFirst()
                    
        UILabel.spawnFloatingFadingLabel(toSuperview: superview,
                                         withFrame: frame,
                                         withColor: color,
                                         withText: firstText,
                                 withCompletion: {
                                    UILabel.spawnFloatingFadingLabels(toSuperview: superview,
                                                                      withFrame: frame,
                                                                      withColor: color,
                                                                      withTexts: remainingTexts,
                                                                      withCompletion: finalCompletion)
        })
    }
    
}
