//
//  GameViewController+MenuDelegate.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController: MenuDelegate {
    
    func menu(_ menu: Menu,
              selectedOption menuOption: MenuOption) {
        soundProvider.play(sfx: .matched)
                
        DispatchQueue.main.async { [weak self] in
            switch menuOption {
            case .start:
                self?.handleStartPressed(menu: menu)
            case .about:
                self?.handleAboutPressed()
            case .highScores:
                self?.handleHighScoresPressed()
            }
        }
    }
    
    // MARK: - Private: Handling -
    
    private func handleStartPressed(menu: Menu) {
        DispatchQueue.main.async { [weak self] in
            self?.gameInProgress = true
            self?.bigGrid?.reset()
            self?.soundProvider.playRandomTune()
            self?.soundProvider.play(sfx: .start)
            self?.currentScore = 0
            self?.logoLabel?.fadeOut(for: 0.4)
            
            menu.fadeOut(for: 0.4,
                         completion: {
                            guard let self = self else { return }
                            
                            UILabel.spawnFloatingFadingLabels(toSuperview: self.view,
                                                              withTexts: [Constants.Text.startGameReadyText1,
                                                                          Constants.Text.startGameReadyText2,
                                                                          Constants.Text.startGameReadyText3]) { [weak self] in
                                self?.spawnGrid(in: .center)
                            }
                         })
        }
    }
    
    private func handleAboutPressed() {
        notificationView?.popin(withText: Constants.Text.aboutDescription)
    }
    
    private func handleHighScoresPressed() {
        let highScores = HighScores.getScores()
        
        var text = Constants.Text.highScoreTitle
        
        var i = 1
        for highScore in highScores {
            text.append(String(format: "%d. %d\n", i, highScore))
            
            i = i + 1
        }
        
        if highScores.count == 0 {
            text.append(Constants.Text.highScoreNoScores)
        }
        
        notificationView?.popin(withText: text)
    }
    
}
