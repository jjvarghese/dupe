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
    @IBOutlet private weak var startButton: UIButton?
    
    var descentInProgress: Bool = false
    var currentTempo: TimeInterval = 0.2
    var gameInProgress: Bool = false
    
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureNavigationBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Actions -
    
    @IBAction private func startPressed(_ sender: Any) {
        startButton?.fadeOut(for: 0.4)
        
        gameInProgress = true
                
        smallGrid?.randomise()
               
        beginDescentOfSmallGrid(withDuration: currentTempo)
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
