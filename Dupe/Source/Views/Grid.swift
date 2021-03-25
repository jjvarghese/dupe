//
//  GridCollectionView.swift
//  Dupe
//
//  Created by Joshua James on 20.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

protocol GridDelegate {
    
    func grid(_ grid: Grid,
              didPanAt indexPath: IndexPath)
    
    func grid(_ grid: Grid,
              didEndPanningAt indexPath: IndexPath)
    
    func grid(_ grid: Grid,
              didSelect indexPath: IndexPath)
            
    func gridDidCollide(_ grid: Grid)
    
}

class Grid: UICollectionView {

    private static let MATCH_DURATION: TimeInterval = 0.3
    static let START_POSITION: CGFloat = 14
    static let STARTING_TEMPO: TimeInterval = 0.2
    static let MAXIMUM_TEMPO: TimeInterval = 0.02
    static let INCREMENT_TEMPO: TimeInterval = 0.01
    
    var descentInProgress: Bool = false
    var gridDelegate: GridDelegate?
    var selectedIndices: [Int] = []
    var swipedIndices: [Int] = []
    var currentTempo: TimeInterval = STARTING_TEMPO

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
        let duration = Grid.MATCH_DURATION
        
        flash(for: duration)
        fadeOut(for: duration,
                shouldReappear: true)

        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            guard let strongSelf = weakSelf else { return }
            
            strongSelf.randomiseActiveCells()
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
    
    func startFalling(collisionGrid: Grid,
                      withTempo tempo: TimeInterval) {
        let topConstraint = superview?.constraints.getTopConstraint(forObject: self)
        
        topConstraint?.constant = Grid.START_POSITION
        
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
