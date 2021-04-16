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
                
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.flicker(on: false)
            
            completion?()
        }
    }
    
    func descend(withTempo tempo: TimeInterval,
                 withSharedGridSpace sharedGridSpace: Int) {
        let topConstraint = superview?.constraints.getTopConstraint(forObject: self)
        
        guard let topLayoutConstraint = topConstraint else { return }
                
        descentInProgress = true
         
        let gridBottom = frame.origin.y + frame.size.height
        
        var stoppingPoint: CGFloat = UIApplication.topViewController()?.view.frame.size.height ?? 0

        stoppingPoint -= (CGFloat(sharedGridSpace) * frame.size.height)
        
        if gridBottom < stoppingPoint {
            topLayoutConstraint.constant += 1
                                    
            UIView.animate(withDuration: tempo,
                           animations: { [weak self] in
                            self?.updateConstraints()
            }) { [weak self] (finished) in
                if finished {
                    DispatchQueue.main.asyncAfter(deadline: .now() + tempo) {
                        self?.descend(withTempo: tempo,
                                      withSharedGridSpace: sharedGridSpace)
                    }
                }
            }
        } else {
            descentInProgress = false
            gridDelegate?.gridDidCollide(self)
        }
    }

    
    // MARK: - Animation Helpers -
    
    private func flicker(on: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            for cell in self.visibleCells {
                if let gridCell = cell as? GridCell {
                    
                    gridCell.update(asSelected: on)
                }
            }
        }
    }
    
}
