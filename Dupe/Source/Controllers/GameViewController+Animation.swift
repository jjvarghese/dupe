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
    
    func descendSmallGrid(withDuration duration: TimeInterval) {
        guard let smallGrid = smallGrid,
            let bigGrid = bigGrid else { return }
         
        let smallGridBottom = smallGrid.frame.origin.y + smallGrid.frame.size.height
        let bigGridTop = bigGrid.frame.origin.y
        
        if smallGridBottom < bigGridTop {
            smallGridTopConstraint?.constant += 1
            
            animateDescent(withDuration: duration)
        }
    }
    
    // MARK: - Animation hekper -
    
    private func animateDescent(withDuration duration: TimeInterval) {
        weak var weakSelf = self

        UIView.animate(withDuration: duration,
                       animations: {
                        weakSelf?.smallGrid?.updateConstraints()
        }) { (finished) in
            if finished {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    weakSelf?.descendSmallGrid(withDuration: duration)
                }
            }
        }
    }
    
}
