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

    func shake(count: Float = 4,
               for duration: TimeInterval = 0.5,
               withTranslation translation: Float = 5,
               withCompletion completion: (() -> Void)? = nil) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration / TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        
        layer.add(animation, forKey: "shake")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            completion?()
        }
    }
    
    func bob() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = 90 / TimeInterval(99)
        animation.autoreverses = true
        animation.values = [5, -5]
        
        layer.add(animation, forKey: "bob")
    }
    
    func fadeOut(for duration: TimeInterval,
                 shouldReappear: Bool = false,
                 completion: (() -> Void)? = nil) {
        weak var weakSelf = self

        UIView.animate(withDuration: duration,
                       animations: {
                        weakSelf?.alpha = 0
        }) { (finished) in
            if shouldReappear {
                UIView.animate(withDuration: 0,
                               animations: {
                                weakSelf?.alpha = 1
                })
            }
            
            if finished {
                completion?()
            }
        }
    }
    
    func floatUp(for duration: TimeInterval) {
        weak var weakSelf = self

        UIView.animate(withDuration: duration) {
            weakSelf?.frame.origin.y -= 30
        }
    }
    
}
