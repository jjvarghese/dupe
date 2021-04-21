//
//  GridCollectionView.swift
//  Dupe
//
//  Created by Joshua James on 20.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit
import Spring

protocol GridDelegate {
    
    func grid(_ grid: Grid,
              didPanAt indexPath: IndexPath)
    
    func grid(_ grid: Grid,
              didEndPanningAt indexPath: IndexPath)
    
    func grid(_ grid: Grid,
              didSelect indexPath: IndexPath)
                
    func gridDidFinishDescending(_ grid: Grid)
    
}

class Grid: SpringView {
    
    var selectedIndices: [Int] = []
    var swipedIndices: [Int] = []
    var delegate: GridDelegate?
    var position: Position?
    var fallVelocity: TimeInterval?
    var rubikColor: RubikColor
    var descentTimer: Timer?
    var isFreshSpawn: Bool = true
    var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                            collectionViewLayout: UICollectionViewFlowLayout())

    var stackRank: StackRank? {
        willSet {
            descentTimer?.invalidate()
            descentTimer = nil
            
            descend()
        }
    }

    // MARK: - NSObject -
    
    required convenience init(withDelegate delegate: GridDelegate) {
        self.init(frame: .zero)

        self.delegate = delegate

        configure()
    }
    
    override init(frame: CGRect) {
        rubikColor = RubikColor.getRandomRubikColor()

        super.init(frame: frame)
        
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

        collectionView.reloadItems(at: [indexPath])
    }

    func randomise() {
        DispatchQueue.main.async { [weak self] in
            let duration = Constants.Values.matchDuration
            
            self?.flash(for: duration - 0.1)
            self?.animate(withAnimation: .pop)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                guard let self = self else { return }
                
                self.randomiseActiveCells()
            }
        }
    }
    
    func reset(withAnimation animation: Animation = .morph) {
        DispatchQueue.main.async { [weak self] in
            self?.isUserInteractionEnabled = false

            self?.flash(for: 0.3,
                  withCompletion: { [weak self] in
                    self?.selectedIndices = []
                    self?.swipedIndices = []
                    self?.collectionView.reloadData()
                    self?.isUserInteractionEnabled = true
                  })
            
            self?.animate(withAnimation: animation)
        }
    }

    // MARK: - Configuration -
    
    private func configure() {
        backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = bounds
        
        addWrappedSubview(subview: collectionView)
        
        configureRegistration()
        configureGestures()
    }
    
    private func configureRegistration() {
        let nib = UINib.init(nibName: Constants.NibNames.GridCell,
                             bundle: nil)
        
        collectionView.register(nib,
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
        
        collectionView.reloadData()
    }
    
}
