//
//  GridCollectionView+Animation.swift
//  Dupe
//
//  Created by Joshua James on 26.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//


import Foundation

extension GridCollectionView {
    
    // MARK: - Available animations -
    
    func flash() {
        flicker(on: true)
        
        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            weakSelf?.flicker(on: false)
        }
    }
    
    // MARK: - Animation Helpers -
    
    private func flicker(on: Bool) {
        for cell in visibleCells {
            if let gridCell = cell as? GridCell {
                gridCell.update(asSelected: on)
            }
        }
    }
    
}
