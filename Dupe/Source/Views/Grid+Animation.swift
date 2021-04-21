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
    
    private func getStoppingPoint() -> CGFloat {
        guard let bottom: CGFloat = UIApplication.topViewController()?.view.frame.size.height,
              let rank = stackRank else { return 0 }
        
        let rankValue = rank.rawValue
        
        return bottom - (CGFloat(rankValue) * frame.size.height)
    }
    
    @objc func descend() {
        configureVelocityAndStartPosition { [weak self] in
            guard let self = self,
                  let velocity = self.fallVelocity else { return }
            
            let topConstraint = self.superview?.constraints.getTopConstraint(forObject: self)
            
            guard let topLayoutConstraint = topConstraint else { return }
                                 
            let gridBottom = self.frame.origin.y + self.frame.size.height
                    
            if gridBottom < self.getStoppingPoint() {
                topLayoutConstraint.constant += 1
                                 
                UIView.animateKeyframes(withDuration: velocity,
                                        delay: 0,
                                        options: .beginFromCurrentState) { [weak self] in
                    self?.layoutIfNeeded()
                } completion: { [weak self] (finished) in
                    guard let self = self else { return }
                    
                    if finished {
                        self.continueDescent()
                    }
                }
            } else {
                self.descentTimer?.invalidate()
                
                self.delegate?.gridDidFinishDescending(self)
            }
        }
    }
    
    private func continueDescent() {
        guard let velocity = fallVelocity else { return }
        
        if descentTimer == nil {
            descentTimer = Timer.scheduledTimer(withTimeInterval: velocity,
                                                repeats: true,
                                                block: { [weak self] (timer) in
                self?.descend()
            })
        }
    }
    
    private func configureVelocityAndStartPosition(withCompletion completion: @escaping () -> Void) {
        TimeInterval.determineVelocity { [weak self] (determinedVelocity) in
            if self?.fallVelocity == nil {
                self?.fallVelocity = determinedVelocity
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if self.isFreshSpawn {
                    self.isFreshSpawn = false
                                
                    let topConstraint = self.superview?.constraints.getTopConstraint(forObject: self)
                    
                    topConstraint?.constant = Constants.Values.gridStartPosition
                    
                    self.updateConstraints()
                }

                completion()
            }
        }
    }
    
    // MARK: - Animation Helpers -
    
    private func flicker(on: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            for cell in self.collectionView.visibleCells {
                if let gridCell = cell as? GridCell {
                    
                    gridCell.update(asSelected: on,
                                    withRubikColor: self.rubikColor)
                }
            }
        }
    }
    
}
