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
