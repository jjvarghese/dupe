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
    @IBOutlet weak var scoreLabel: UILabel?
    @IBOutlet weak var menu: Menu?
    
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
    
    private static var _baseRubikColor: UIColor?
    static var baseRubikColor: UIColor {
        get {
            if let baseColor = _baseRubikColor {
                return baseColor
            } else {
                let newColor = RubikColor.getRandomRubikColor()
                
                _baseRubikColor = newColor
                
                return newColor
            }
        }
        set {
            if baseRubikColor == newValue || newValue == activeRubikColor {
                _baseRubikColor = RubikColor.getRandomRubikColor()
            } else {
                _baseRubikColor = newValue
            }
        }
    }
    
    private static var _activeRubikColor: UIColor?
    static var activeRubikColor: UIColor {
        get {
            if let activeColor = _activeRubikColor {
                return activeColor
            } else {
                let newColor = RubikColor.getRandomRubikColor()
                
                _activeRubikColor = newColor
                
                return newColor
            }
        }
        set {
            if activeRubikColor == newValue || newValue == baseRubikColor {
                _activeRubikColor = RubikColor.getRandomRubikColor()
            } else {
                _activeRubikColor = newValue
            }
        }
    }
    
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        
        configureSubviews()
        configureNavigationBar()
        
        startNewRound()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureCollectionViews()
        configureMenu()
        configureScoreLabel()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionViews() {
        configure(grid: bigGrid)
        
        bigGrid?.borderWidth = 3.0
    }
    
    private func configureScoreLabel() {
        scoreLabel?.isHidden = true
        scoreLabel?.theme(withSize: 20)
    }
    
    private func configureMenu() {
        menu?.delegate = self
        menu?.dataSource = self
        menu?.menuDelegate = self
    }
    
    func configure(grid: Grid?) {
        grid?.delegate = self
        grid?.dataSource = self
        grid?.gridDelegate = self
    }

}
