//
//  TimeInterval+Velocity.swift
//  Dupe
//
//  Created by Joshua James on 17.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension TimeInterval {
    
    static func determineVelocity(withCompletion completion: @escaping (TimeInterval) -> Void) {
        DispatchQueue.main.async {
            guard let vc = UIApplication.topViewController() else { return }
            
            let window = UIApplication.shared.windows.first
            let top = (window?.safeAreaInsets.top ?? 0) + Constants.Values.gridStartPosition
            let collisionPoint = vc.view.frame.size.height
            let bottom = top + (vc.view.frame.size.height / 5)
            let distanceToFall = collisionPoint - bottom
            let timeToFall: CGFloat = Constants.Values.initialTimeToFall
            let pixelsPerSecond = distanceToFall / timeToFall
            let finalTempo = TimeInterval(1 / pixelsPerSecond)
            
            completion(finalTempo)
        }
    }
    
}
