//
//  GameViewController+Animation.swift
//  Dupe
//
//  Created by Joshua James on 26.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController {
    
    func spawnFloatingFadingLabels(withTexts texts: [String],
                                   withCompletion finalCompletion: (() -> Void)?) {
        guard texts.count > 0 else {
            finalCompletion?()
            
            return
        }
        
        var remainingTexts = texts
        
        let firstText = remainingTexts.removeFirst()
            
        weak var weakSelf = self
        
        spawnFloatingFadingLabel(withText: firstText,
                                 withCompletion: {
                                    weakSelf?.spawnFloatingFadingLabels(withTexts:  remainingTexts,
                                                                        withCompletion: finalCompletion)
        })    
    }
    
    func spawnFloatingFadingLabel(withText text: String,
                                  withCompletion completion: (() -> Void)? = nil) {
        let label: UILabel = UILabel(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: view.frame.size.width,
                                                    height: 50))
        label.center = view.center
        label.text = text
        label.textColor = .white
        label.font = UIFont(name: "8-bit",
                            size: 37)
        label.textAlignment = .center
        
        view.addSubview(label)
        
        let duration = 0.75
        
        label.floatUp(for: duration)
        label.fadeOut(for: duration)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            label.removeFromSuperview()
            
            completion?()
        }
    }
    
}
