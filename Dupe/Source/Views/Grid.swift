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
    var velocity: TimeInterval = 0
    var rubikColor: RubikColor

    // MARK: - NSObject -
    
    required convenience init(withGriddable griddable: Griddable) {
        self.init(frame: .zero,
                  collectionViewLayout: UICollectionViewFlowLayout())
        
        gridDelegate = griddable
        delegate = griddable
        dataSource = griddable
        
        configure()
    }
    
    convenience init() {
        self.init(frame: .zero,
                   collectionViewLayout: UICollectionViewFlowLayout())
        
        configure()
    }
    
    override init(frame: CGRect,
                  collectionViewLayout layout: UICollectionViewLayout) {
        rubikColor = RubikColor.getRandomRubikColor()
        
        super.init(frame: frame,
                   collectionViewLayout: layout)
                
        configure()
    }
    
    required init?(coder: NSCoder) {
        rubikColor = RubikColor.getRandomRubikColor()

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
        DispatchQueue.main.async { [weak self] in
            let duration = Grid.MATCH_DURATION
            
            self?.flash(for: duration - 0.1)
            self?.shake(count: 1,
                        for: 0.1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                guard let self = self else { return }
                
                self.randomiseActiveCells()
            }
        }
    }
    
    func reset() {
        DispatchQueue.main.async { [weak self] in
            self?.isUserInteractionEnabled = false

            self?.flash(for: 0.3,
                  withCompletion: { [weak self] in
                    self?.selectedIndices = []
                    self?.swipedIndices = []
                    self?.reloadData()
                    self?.isUserInteractionEnabled = true
                  })
            
            self?.shake(count: 1,
                  for: 0.2)
        }
    }
    
    func startFalling(withTempo tempo: TimeInterval? = nil,
                      withSharedGridSpace sharedGridSpace: Int) {
        if let tempo = tempo {
            velocity = tempo
            
            let topConstraint = superview?.constraints.getTopConstraint(forObject: self)
            
            topConstraint?.constant = Grid.START_POSITION
            
            updateConstraints()
        }

        if !descentInProgress {
            descend(withTempo: velocity,
                    withSharedGridSpace: sharedGridSpace)
        }
    }

    // MARK: - Configuration -
    
    func configureDelegates(toGriddable griddable: Griddable) {
        gridDelegate = griddable
        delegate = griddable
        dataSource = griddable
    }
    
    private func configure() {
        backgroundColor = .clear
        
        configureRegistration()
        configureGestures()
    }
    
    private func configureRegistration() {
        let nib = UINib.init(nibName: Constants.NibNames.GridCell,
                             bundle: nil)
        
        register(nib,
                 forCellWithReuseIdentifier: Constants.CellIdentifiers.GridCell)
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
