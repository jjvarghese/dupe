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
    
    func beginDescentOfSmallGrid(withDuration duration: TimeInterval) {
        currentTempo = duration
        
        smallGridTopConstraint?.constant = 14
        
        smallGrid?.updateConstraints()
        
        if !descentInProgress {
            descendSmallGrid()
        }
    }
    
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
        label.font = UIFont(name: "AmericanTypewriter",
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
    
    // MARK: - Animation helper -
    
    private func descendSmallGrid() {
        guard let smallGrid = smallGrid,
            let bigGrid = bigGrid else { return }
        
        descentInProgress = true
         
        let smallGridBottom = smallGrid.frame.origin.y + smallGrid.frame.size.height
        let bigGridTop = bigGrid.frame.origin.y
        
        if smallGridBottom < bigGridTop {
            smallGridTopConstraint?.constant += 1
            
            animateDescent()
        } else {
            triggerGameOver()
        }
    }
    
    private func animateDescent() {
        weak var weakSelf = self

        let duration = currentTempo
        
        UIView.animate(withDuration: duration,
                       animations: {
                        weakSelf?.smallGrid?.updateConstraints()
        }) { (finished) in
            if finished {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    weakSelf?.descendSmallGrid()
                }
            }
        }
    }
    
}
