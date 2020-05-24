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
    
    private var swipedIndices: [Int] = []
    
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
        let length = 10
        
        selectedIndices.addIfNotAlreadyThere(element: seedIndex)
        
        for var i in 0...length {
            let validOptions: [Int] = seedIndex.getSmoothPathsForSize16Grid()
            let selectedOptionPosition = Int.random(in: 0...validOptions.count)
            
            if let nextIndex = validOptions[safe: selectedOptionPosition] {
                selectedIndices.addIfNotAlreadyThere(element: nextIndex)
            }
            
            
            i += 1
        }
        
        reloadData()
    }
    
    func reset() {
        selectedIndices = []
        swipedIndices = []
        
        for cell in visibleCells {
            if let gridCell = cell as? GridCell {
                gridCell.update(asSelected: false)
            }
        }
        
        reloadData()
    }
    
    // MARK: - Gesture Handling -
    
    @objc private func didTap(touchGesture: UITapGestureRecognizer) {
        let location = touchGesture.location(in: self)
        
        if let indexPath = indexPathForItem(at: location) {
            gridDelegate?.gridCollectionView(collectionView: self,
                                             didSelect: indexPath)
        }
    }
    
    @objc private func didPan(panGesture: UIPanGestureRecognizer) {
        let location = panGesture.location(in: self)
        
        if let indexPath = indexPathForItem(at: location) {
            if panGesture.state == .began {
                gridDelegate?.gridCollectionView(collectionView: self,
                                                 didSelect: indexPath)
                
                swipedIndices.addIfNotAlreadyThere(element: indexPath.item)
            } else if panGesture.state == .changed {
                gridDelegate?.gridCollectionView(collectionView: self,
                                                 didPanAt: indexPath)
                
                swipedIndices.addIfNotAlreadyThere(element: indexPath.item)
            } else if panGesture.state == .ended {

                swipedIndices = []
                
                gridDelegate?.gridCollectionView(collectionView: self,
                                                 didEndPanningAt: indexPath)
            }
        }
    }
    
    // MARK: - Configuration -
    
    private func configureGestures() {
        let swipeGesture: UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self,
                                                                               action: #selector(didPan(panGesture:)))
        swipeGesture.delegate = self
        swipeGesture.cancelsTouchesInView = false
        
        addGestureRecognizer(swipeGesture)
        
        let touchGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self,
                                                                               action: #selector(didTap(touchGesture:)))
        touchGesture.delegate = self
        touchGesture.numberOfTapsRequired = 1
        touchGesture.numberOfTouchesRequired = 1
        touchGesture.cancelsTouchesInView = false
        
        addGestureRecognizer(touchGesture)
    }

}
