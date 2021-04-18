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
       
    @IBOutlet weak var bottomRightColorPicker: ColorPicker?
    @IBOutlet weak var bottomLeftColorPicker: ColorPicker?
    @IBOutlet weak var topLeftColorPicker: ColorPicker?
    @IBOutlet weak var topRightColorPicker: ColorPicker?
    
    var colorPickers: [ColorPicker?] = []
    
    let soundProvider: SoundProvider = SoundProvider()
    
    var session: GameSession? {
        willSet {
            if newValue == nil {
                menu?.backgroundColor = bigGrid?.rubikColor.color() ?? .clear
                menu?.fade(out: false,
                           for: 0.4)
                
                for colorPicker in colorPickers {
                    colorPicker?.fade(out: true,
                                      for: 0.4)
                }
            } else {
                menu?.fade(out: true,
                           for: 0.4,
                             completion: { [weak self] in
                                guard let self = self else { return }
                                
                                UILabel.spawnFloatingFadingLabels(toSuperview: self.view,
                                                                  withTexts: [Constants.Text.startGameReadyText1,
                                                                              Constants.Text.startGameReadyText2,
                                                                              Constants.Text.startGameReadyText3]) {
                                    newValue?.spawnGrid()
                                    
                                    for colorPicker in self.colorPickers {
                                        colorPicker?.fade(out: false,
                                                          for: 0.4)
                                    }
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
        logoLabel?.themeAsLogo(withColor: bigGrid?.rubikColor.color())
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureCollectionViews() {
        bottomLeftColorPicker?.configure(toColorPickable: self,
                                         withRubikColor: .blue)
        bottomRightColorPicker?.configure(toColorPickable: self,
                                          withRubikColor: .orange)
        topLeftColorPicker?.configure(toColorPickable: self,
                                      withRubikColor: .red)
        topRightColorPicker?.configure(toColorPickable: self,
                                       withRubikColor: .yellow)
        
        colorPickers = [bottomLeftColorPicker,
                        bottomRightColorPicker,
                        topLeftColorPicker,
                        topRightColorPicker]
        
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
