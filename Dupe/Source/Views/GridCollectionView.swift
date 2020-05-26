//
//  GridCollectionView.swift
//  Dupe
//
//  Created by Joshua James on 20.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

protocol GridCollectionViewDelegate {
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didPanAt indexPath: IndexPath)
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didEndPanningAt indexPath: IndexPath)
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didSelect indexPath: IndexPath)
    
}

class GridCollectionView: UICollectionView {

    var gridDelegate: GridCollectionViewDelegate?
    var selectedIndices: [Int] = []
    var swipedIndices: [Int] = []
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureGestures()
    }
    
    // MARK: - Updating -
    
    func touch(indexPath: IndexPath) {
        guard !swipedIndices.contains(indexPath.item) else { return }
        
        selectedIndices.toggle(element: indexPath.item)

        reloadItems(at: [indexPath])
    }

    func randomise() {
        selectedIndices = []
        
        let seedIndex = Int.random(in: 0...15)
        let length = 5
        
        selectedIndices.addIfNotAlreadyThere(element: seedIndex)
        
        for var i in 0...length {
            let validOptions: Array = i.getSmoothPathsForSize16Grid()
            
            let chosenOption = Int.random(in: 0...validOptions.count)
            
            if let chosenIndex = validOptions[safe: chosenOption] {
                selectedIndices.addIfNotAlreadyThere(element: chosenIndex)
            }
            
            i += 1
        }
        
        reloadData()
    }
    
    func reset() {
        selectedIndices = []
        swipedIndices = []
        
        flash()
        
        reloadData()
    }
    
}
