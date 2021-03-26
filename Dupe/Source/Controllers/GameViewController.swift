//
//  GameViewController.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    static let STARTING_TEMPO: TimeInterval = 0.2
    static let MAXIMUM_TEMPO: TimeInterval = 0.02
    static let INCREMENT_TEMPO: TimeInterval = 0.01
    static let THRESHOLD_TEMPO_FOR_EXTRA_SPAWN: TimeInterval = 0.1

    var tempo: TimeInterval = STARTING_TEMPO
    var grids: [Grid] = []

    @IBOutlet weak var bigGrid: Grid?
    @IBOutlet weak var startButton: UIButton?
    @IBOutlet weak var scoreLabel: UILabel?
    

    let soundProvider: SoundProvider = SoundProvider()
    
    private var _currentScore: Int?
    var currentScore: Int {
        get {
            return _currentScore ?? 0
        }
        set {
            _currentScore = newValue
            
            scoreLabel?.text = String(format: "Your score: %d", newValue)
        }
    }
    
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        configureSubviews()
        configureNavigationBar()
        startNewRound()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Actions -
    
    @IBAction private func startPressed(_ sender: Any) {
        soundProvider.playRandomTune()
        soundProvider.play(sfx: .start)
        scoreLabel?.isHidden = true
        currentScore = 0
        
        guard let startButton = startButton else { return }
        
        weak var weakSelf = self
        
        startButton.fadeOut(for: 0.4,
                             completion: {
                                weakSelf?.spawnFloatingFadingLabels(withTexts: ["Ready...", "Set...", "DUPE!"], withCompletion: {
                                    weakSelf?.spawnGrid(in: .center)
                                })
        })
        
        
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureCollectionViews()
        configureStartButton()
        configureScoreLabel()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionViews() {
        configure(grid: bigGrid)
    }
    
    private func configureStartButton() {
        startButton?.backgroundColor = UIColor.base
        startButton?.titleLabel?.font = UIFont(name: "8-bit",
                                               size: 37)
    }
    
    private func configureScoreLabel() {
        scoreLabel?.isHidden = true
        scoreLabel?.font = UIFont(name: "8-bit",
                            size: 20)
    }
    
    func configure(grid: Grid?) {
        grid?.register(UINib.init(nibName: GridCell.NibName,
                                  bundle: nil),
                       forCellWithReuseIdentifier: GridCell.CellIdentifier)
        grid?.delegate = self
        grid?.dataSource = self
        grid?.backgroundColor = .clear
        grid?.gridDelegate = self 
    }

}
