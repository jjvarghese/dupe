//
//  GameViewController.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var bigGrid: Grid!
    @IBOutlet var logoLabel: UILabel!
    @IBOutlet var menu: Menu!
       
    let soundProvider: SoundProvider = SoundProvider()
    
    var session: GameSession? {
        willSet {
            if newValue == nil {
                menu.backgroundColor = bigGrid.rubikColor.color()
                menu.fade(out: false,
                           for: 0.4)
            } else {
                menu.fade(out: true,
                           for: 0.4,
                             completion: { [weak self] in
                                guard let self = self else { return }
                                
                                UILabel.spawnFloatingFadingLabels(toSuperview: self.view,
                                                                  withColor: self.bigGrid.rubikColor.color(),
                                                                  withTexts: [Constants.Text.startGameReadyText1,
                                                                              Constants.Text.startGameReadyText2,
                                                                              Constants.Text.startGameReadyText3]) {
                                    newValue?.spawnGrid()
                                    
                                    self.soundProvider.playRandomTune()
                                }
                             })
            }
        }
    }
        
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        
        configureSubviews()
        configureNavigationBar()
        configureNotifications()
        
        session = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Configuration -
    
    private func configureNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appWillEnterForegroundNotificationReceived(_:)),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    private func configureSubviews() {
        configureLogo()
        configureMenu()
        configureCollectionViews()
    }
    
    private func configureLogo() {
        logoLabel.themeAsLogo(withColor: bigGrid?.rubikColor.color())
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionViews() {
        guard let bigGrid = bigGrid else { return }
                
        bigGrid.accessibilityIdentifier = "BigGrid"
        bigGrid.delegate = self
    }
    
    private func configureMenu() {
        menu.delegate = self
        menu.dataSource = self
        menu.menuDelegate = self
    }
    
}
