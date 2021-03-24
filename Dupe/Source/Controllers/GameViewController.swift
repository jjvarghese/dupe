//
//  GameViewController.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
//    var session: GameSession = GameSession()
    
    var gameInProgress: Bool = false
    
    var grids: [Grid] = []

    @IBOutlet weak var bigGrid: Grid?
    @IBOutlet weak var startButton: UIButton?
    @IBOutlet weak var scoreLabel: UILabel?
    
    static let THRESHOLD_TEMPO_FOR_INSANITY: TimeInterval = 0.1
    static let INSANITY_MODE_DURATION = 15.0

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
    
    private var _isInsaneMode: Bool?
    var isInsaneMode: Bool {
        get {
            return _isInsaneMode ?? false
        }
        set {
            _isInsaneMode = newValue
            
            soundProvider.playRandomTune()
            
            bigGrid?.reloadData()
            
            if newValue == true {
                startInsanityMode()
            }
        }
    }
    
    var insanityTimer: Timer?
    
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureNavigationBar()
        configureSound()
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
                                weakSelf?.spawnFloatingFadingLabels(withTexts: ["READY", "SET", "DUPE!"], withCompletion: {
                                                                        weakSelf?.spawnGrid()
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
    }
    
    private func configureScoreLabel() {
        scoreLabel?.isHidden = true
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
    
    private func configureSound() {
        
    }

}
