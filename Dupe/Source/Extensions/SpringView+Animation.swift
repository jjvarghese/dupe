//
//  SpringView+Animation.swift
//  Dupe
//
//  Created by Joshua James on 21.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import Spring

extension SpringView {
    
    func animate(withAnimation animation: Animation,
                 withCompletion completion: (() -> Void)? = nil) {
        self.animation = animation.rawValue
        self.animateNext {
            completion?()
        }
    }
    
}
