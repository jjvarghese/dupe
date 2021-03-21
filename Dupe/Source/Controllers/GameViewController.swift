//
//  GameViewController.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var smallGrid: GridCollectionView?
    @IBOutlet weak var bigGrid: GridCollectionView?
    @IBOutlet weak var rightGrid: GridCollectionView?
    @IBOutlet weak var leftGrid: GridCollectionView?
    
    @IBOutlet weak var startButton: UIButton?
    @IBOutlet weak var scoreLabel: UILabel?
    
    static let STARTING_TEMPO: TimeInterval = 0.2
    static let MAXIMUM_TEMPO: TimeInterval = 0.02
    static let INCREMENT_TEMPO: TimeInterval = 0.01
    static let THRESHOLD_TEMPO_FOR_INSANITY: TimeInterval = 0.1
    static let INSANITY_MODE_DURATION = 15.0
    
    var currentTempo: TimeInterval = STARTING_TEMPO
    var gameInProgress: Bool = false

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
            
            if newValue == true {
                startInsanityMode()
            } else {
                endInsanityMode()
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
        smallGrid?.isHidden = false
        scoreLabel?.isHidden = true
        currentScore = 0
        
        guard let startButton = startButton else { return }
        
        weak var weakSelf = self
        
        startButton.fadeOut(for: 0.4,
                             completion: {
                                weakSelf?.spawnFloatingFadingLabels(withTexts: ["READY", "SET", "DUPE!"], withCompletion: {
                                    weakSelf?.release(grid: weakSelf?.smallGrid)
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
        configure(grid: smallGrid)
        configure(grid: bigGrid)
        configure(grid: leftGrid)
        configure(grid: rightGrid)
                
        leftGrid?.isHidden = true
        rightGrid?.isHidden = true
    }
    
    private func configureStartButton() {
        startButton?.backgroundColor = UIColor.base
    }
    
    private func configureScoreLabel() {
        scoreLabel?.isHidden = true
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
    
    private func configureSound() {
        
    }

}
