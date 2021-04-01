//
//  GridCell+Animation.swift
//  Dupe
//
//  Created by Joshua James on 26.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GridCell {
    
    // MARK: - Available animations -
    
    func pulse() {
        let pulseDuration = 0.3
        
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf?.adjustSquareSize(amount: -5)
            
            UIView.animate(withDuration: pulseDuration,
                           animations: {
                            weakSelf?.layoutIfNeeded()
            }) { (finished) in
                if finished {
                    weakSelf?.adjustSquareSize(amount: weakSelf?.size.borderThickness ?? 0)
                    
                    UIView.animate(withDuration: pulseDuration) {
                        weakSelf?.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    // MARK: - Animation helper -
    
    private func adjustSquareSize(amount: CGFloat) {
        weak var weakSelf = self

        DispatchQueue.main.async {
            weakSelf?.squareTopConstraint?.constant = amount
            weakSelf?.squareBottomConstraint?.constant = amount
            weakSelf?.squareLeadingConstraint?.constant = amount
            weakSelf?.squareTrailingConstraint?.constant = amount
        }
    }
    
}
