//
//  GameViewController.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var bigGrid: Grid?
    @IBOutlet weak var logoLabel: UILabel?
    @IBOutlet weak var menu: Menu?

    var tempo: TimeInterval = 0
    var grids: [Grid] = []
    var gameInProgress: Bool = false
   
    var notificationView: NotificationView? = UINib(nibName: Constants.NibNames.NotificationView,
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
                
        configure(grid: bigGrid)
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
