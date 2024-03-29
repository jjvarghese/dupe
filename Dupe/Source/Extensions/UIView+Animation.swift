//
//  UIView+Animation.swift
//  Dupe
//
//  Created by Joshua James on 28.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

    func bob() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = 90 / TimeInterval(99)
        animation.autoreverses = true
        animation.values = [5, -5]
        
        layer.add(animation, forKey: "bob")
    }
    
    func fade(out: Bool,
              for duration: TimeInterval,
              shouldReappear: Bool = false,
              completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       animations: { [weak self] in
                        self?.alpha = out ? 0 : 1
                       }) { [weak self] (finished) in
            if shouldReappear {
                UIView.animate(withDuration: 0,
                               animations: {
                                self?.alpha = out ? 1 : 0
                })
            }
            
            if finished {
                completion?()
            }
        }
    }
    
    func floatUp(for duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.frame.origin.y -= 30
        }
    }
    
}
