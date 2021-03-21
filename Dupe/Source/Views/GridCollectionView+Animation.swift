//
//  GridCollectionView+Animation.swift
//  Dupe
//
//  Created by Joshua James on 26.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GridCollectionView {
    
    // MARK: - Available animations -
    
    func flash(for duration: TimeInterval) {
        flicker(on: true)
        
        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            weakSelf?.flicker(on: false)
        }
    }
    
    func descend(collisionGrid: GridCollectionView) {
        let topConstraint = superview?.constraints.getTopConstraint(forObject: self)
        
        guard let topLayoutConstraint = topConstraint,
              let tempo = gridDelegate?.gridCollectionViewRequestsCurrentTempo(collectionView: self) else { return }
                
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
                        weakSelf?.descend(collisionGrid: collisionGrid)
                    }
                }
            }
        } else {
            gridDelegate?.gridCollectionViewDidCollide(collectionView: self)
        }
    }
    
    // MARK: - Animation Helpers -
    
    private func flicker(on: Bool) {
        for cell in visibleCells {
            if let gridCell = cell as? GridCell {
                gridCell.update(asSelected: on,
                                isInsanityMode: gridDelegate?.gridCollectionViewRequestsInsanityMode(collectionView: self) ?? false)
            }
        }
    }
    
}
