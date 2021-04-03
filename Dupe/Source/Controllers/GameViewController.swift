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
    var gameInProgress: Bool = false

    @IBOutlet weak var bigGrid: Grid?
    @IBOutlet weak var logoLabel: UILabel?

    var menu: Menu?
    var notificationView: NotificationView? = UINib(nibName: NotificationView.NibName,
                                                    bundle: nil).instantiate(withOwner: self, options: nil).first as? NotificationView
    
    let soundProvider: SoundProvider = SoundProvider()
    
    var currentScore: Int = 0
    
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
    
    static var activeRubikColor: UIColor = .white
    
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
        configureLogo()
        configureMenu()
        configureCollectionViews()
    }
    
    private func configureLogo() {
        logoLabel?.themeAsLogo()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionViews() {
        guard let bigGrid = bigGrid else { return }
        
        bigGrid.size = .large
        
        configure(grid: bigGrid)
    }
    
    private func configureMenu() {
        guard let bigGrid = bigGrid else { return }
        
        menu = Menu(frame: .zero)
        menu?.delegate = self
        menu?.dataSource = self
        menu?.menuDelegate = self
        
        if let menu = menu {
            bigGrid.addSubviewWithConstraints(subview: menu,
                                              atPosition: .center,
                                              withWidth: bigGrid.frame.size.width - 112,
                                              withHeight: bigGrid.frame.size.height - 112,
                                              withVerticalOffset: 9)
        }
    }
    
    func configure(grid: Grid?) {
        grid?.delegate = self
        grid?.dataSource = self
        grid?.gridDelegate = self 
    }

}
