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
    
    func gridCollectionViewDidFinishMatchAnimation(collectionView: GridCollectionView)
    
    func gridCollectionViewDidCollide(collectionView: GridCollectionView)
    
    func gridCollectionViewRequestsInsanityMode(collectionView: GridCollectionView) -> Bool
    
    func gridCollectionViewRequestsCurrentTempo(collectionView: GridCollectionView) -> TimeInterval
        
}

class GridCollectionView: UICollectionView {

    static private let START_POSITION: CGFloat = 14

    var gridDelegate: GridCollectionViewDelegate?
    var selectedIndices: [Int] = []
    var swipedIndices: [Int] = []
    var descentInProgress: Bool = false

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
        let duration = 0.3
        
        flash(for: duration)
        fadeOut(for: duration,
                shouldReappear: true)

        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            guard let strongSelf = weakSelf else { return }
            
            strongSelf.randomiseActiveCells()
            strongSelf.gridDelegate?.gridCollectionViewDidFinishMatchAnimation(collectionView: strongSelf)
        }
    }
    
    func reset() {
        selectedIndices = []
        swipedIndices = []
        
        flash(for: 0.3)
        shake(count: 1,
              for: 0.2)
        
        reloadData()
    }
    
    func startFalling(collisionGrid: GridCollectionView,
                      withTempo tempo: TimeInterval) {
        let topConstraint = superview?.constraints.getTopConstraint(forObject: self)
        
        topConstraint?.constant = GridCollectionView.START_POSITION
        frame.origin.y = GridCollectionView.START_POSITION
        
        updateConstraints()
        
        if !descentInProgress {
            descend(collisionGrid: collisionGrid)
        }
    }
    
    // MARK: - Private -
    
    private func randomiseActiveCells() {
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
    
}
