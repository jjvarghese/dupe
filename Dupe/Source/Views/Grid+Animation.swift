//
//  GridCollectionView+Animation.swift
//  Dupe
//
//  Created by Joshua James on 26.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//


import Foundation
import UIKit

extension Grid {
    
    // MARK: - Available animations -
    
    func flash(for duration: TimeInterval,
               withCompletion completion: (() -> Void)? = nil) {
        flicker(on: true)
        
        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            weakSelf?.flicker(on: false)
            completion?()
        }
    }
    
    func descend(collisionGrid: Grid,
                 withTempo tempo: TimeInterval) {
        let topConstraint = superview?.constraints.getTopConstraint(forObject: self)
        
        guard let topLayoutConstraint = topConstraint else { return }
                
        descentInProgress = true
         
        let gridBottom = frame.origin.y + frame.size.height
        let collisionPoint = collisionGrid.frame.origin.y
        
        if gridBottom < collisionPoint {
            topLayoutConstraint.constant += 1
            
            weak var weakSelf = self
                        
            UIView.animate(withDuration: tempo,
                           animations: {
                            weakSelf?.updateConstraints()
            }) { (finished) in
                if finished {
                    DispatchQueue.main.asyncAfter(deadline: .now() + tempo) {
                        weakSelf?.descend(collisionGrid: collisionGrid,
                                          withTempo: tempo)
                    }
                }
            }
        } else {
            gridDelegate?.gridDidCollide(self)
        }
    }

    
    // MARK: - Animation Helpers -
    
    private func flicker(on: Bool) {
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            for cell in strongSelf.visibleCells {
                if let gridCell = cell as? GridCell {
                    
                    gridCell.update(asSelected: on)
                }
            }
        }
    }
    
}
