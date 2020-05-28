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
               withTranslation translation: Float = 5) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        
        layer.add(animation, forKey: "shake")
    }
    
}
