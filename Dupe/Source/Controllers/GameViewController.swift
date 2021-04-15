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
   
    let soundProvider: SoundProvider = SoundProvider()
   

    
    var session: GameSession?
        
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.background
        
        configureSubviews()
        configureNavigationBar()
        configureNotifications()
        
        startNewRound()
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
        logoLabel?.themeAsLogo()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionViews() {
        guard let bigGrid = bigGrid else { return }
                
        bigGrid.accessibilityIdentifier = "BigGrid"
        bigGrid.configureDelegates(toGriddable: self)
    }
    
    private func configureMenu() {
        menu?.delegate = self
        menu?.dataSource = self
        menu?.menuDelegate = self
    }
    


}
