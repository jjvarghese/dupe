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
    
    @objc func descend(withSharedGridSpace sharedGridSpace: Int) {
        guard let velocity = velocity else { return }
        
        let topConstraint = superview?.constraints.getTopConstraint(forObject: self)
        
        guard let topLayoutConstraint = topConstraint else { return }
                
        descentInProgress = true
         
        let gridBottom = frame.origin.y + frame.size.height
        
        var stoppingPoint: CGFloat = UIApplication.topViewController()?.view.frame.size.height ?? 0

        stoppingPoint -= (CGFloat(sharedGridSpace) * frame.size.height)
        
        if gridBottom < stoppingPoint {
            topLayoutConstraint.constant += 1
                             
            UIView.animateKeyframes(withDuration: velocity,
                                    delay: 0,
                                    options: .beginFromCurrentState) { [weak self] in
                self?.layoutIfNeeded()
            } completion: { [weak self] (finished) in
                guard let self = self else { return }
                
                if finished {
                    self.continueDescent(withSharedGridSpace: sharedGridSpace)
                }
            }
        } else {
            descentInProgress = false
            descentTimer?.invalidate()
            
            gridDelegate?.gridDidFinishDescending(self)
        }
    }
    
    private func continueDescent(withSharedGridSpace sharedGridSpace: Int) {
        guard let velocity = velocity else { return }
        
        if descentTimer == nil {
            descentTimer = Timer.scheduledTimer(withTimeInterval: velocity,
                                                repeats: true,
                                                block: { [weak self] (timer) in
                self?.descend(withSharedGridSpace: sharedGridSpace)
            })
        }
    }
    
    // MARK: - Animation Helpers -
    
    private func flicker(on: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            for cell in self.visibleCells {
                if let gridCell = cell as? GridCell {
                    
                    gridCell.update(asSelected: on,
                                    withRubikColor: self.rubikColor)
                }
            }
        }
    }
    
}
