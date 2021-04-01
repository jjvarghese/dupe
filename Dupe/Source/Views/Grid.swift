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
    
    var descentInProgress: Bool = false
    var gridDelegate: GridDelegate?
    var selectedIndices: [Int] = []
    var swipedIndices: [Int] = []
    var position: Position?
    
    var size: GridSize

    // MARK: - NSObject -
    
    required init(withSize gridSize: GridSize) {
        size = gridSize
        
        super.init(frame: .zero,
                   collectionViewLayout: UICollectionViewFlowLayout.init())
        
        configure()
    }
    
    override init(frame: CGRect,
                  collectionViewLayout layout: UICollectionViewLayout) {
        size = .small
        
        super.init(frame: frame,
                   collectionViewLayout: layout)
                
        configure()
    }
    
    required init?(coder: NSCoder) {
        size = .small
        
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    // MARK: - Updating -
    
    func touch(indexPath: IndexPath) {
        guard !swipedIndices.contains(indexPath.item) else { return }
        
        selectedIndices.toggle(element: indexPath.item)

        reloadItems(at: [indexPath])
    }

    func randomise() {
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            let duration = Grid.MATCH_DURATION
            
            weakSelf?.flash(for: duration - 0.1)
            weakSelf?.shake(count: 1, for: 0.1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                guard let strongSelf = weakSelf else { return }
                
                strongSelf.randomiseActiveCells()
            }
        }
    }
    
    func reset() {
        weak var weakSelf = self

        DispatchQueue.main.async {
            weakSelf?.isUserInteractionEnabled = false

            weakSelf?.flash(for: 0.3,
                  withCompletion: {
                    weakSelf?.selectedIndices = []
                    weakSelf?.swipedIndices = []
                    weakSelf?.reloadData()
                    weakSelf?.isUserInteractionEnabled = true
                  })
            
            weakSelf?.shake(count: 1,
                  for: 0.2)
        }
    }
    
    func startFalling(collisionGrid: Grid,
                      withTempo tempo: TimeInterval) {
        let topConstraint = superview?.constraints.getTopConstraint(forObject: self)
        
        topConstraint?.constant = Grid.START_POSITION
        
        updateConstraints()
        
        if !descentInProgress {
            descend(collisionGrid: collisionGrid,
                    withTempo: tempo)
        }
    }

    // MARK: - Configuration -
    
    private func configure() {
        backgroundColor = .clear
        
        configureRegistration()
        configureGestures()
    }
    
    private func configureRegistration() {
        let nib = UINib.init(nibName: GridCell.NibName,
                             bundle: nil)
        
        register(nib,
                 forCellWithReuseIdentifier: GridCell.CellIdentifier)
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
