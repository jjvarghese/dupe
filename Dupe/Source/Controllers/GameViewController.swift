//
//  GameViewController.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var smallGridTopConstraint: NSLayoutConstraint?
    @IBOutlet weak var smallGrid: GridCollectionView?
    @IBOutlet weak var bigGrid: GridCollectionView?
    
    var descentInProgress: Bool = false
    var currentTempo: TimeInterval = 0.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureNavigationBar()
        
        smallGrid?.randomise()
        
        beginDescentOfSmallGrid(withDuration: currentTempo)
    }
    
    // MARK: - Matching -
    
    func triggerMatch() {
        bigGrid?.reset()
        smallGrid?.randomise()
    }
    
    func startNewRound() {
        descentInProgress = false
        
        smallGridTopConstraint?.constant = 14
        
        smallGrid?.updateConstraints()
        
        currentTempo = 0.2
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureCollectionViews()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionViews() {
        configure(grid: smallGrid)
        configure(grid: bigGrid)
    }
    
    private func configure(grid: GridCollectionView?) {
        grid?.register(UINib.init(nibName: GridCell.NibName,
                                  bundle: nil),
                       forCellWithReuseIdentifier: GridCell.CellIdentifier)
        grid?.delegate = self
        grid?.dataSource = self
        grid?.backgroundColor = .clear
        grid?.gridDelegate = self 
    }

}
