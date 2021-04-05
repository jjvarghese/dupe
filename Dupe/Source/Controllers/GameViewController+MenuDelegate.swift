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
        
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            switch menuOption {
            case .start:
                weakSelf?.handleStartPressed(menu: menu)
            case .about:
                weakSelf?.handleAboutPressed()
            case .highScores:
                weakSelf?.handleHighScoresPressed()
            }
        }
    }
    
    // MARK: - Private: Handling -
    
    private func handleStartPressed(menu: Menu) {
        weak var weakSelf = self

        DispatchQueue.main.async {
            weakSelf?.gameInProgress = true
            weakSelf?.bigGrid?.reset()
            weakSelf?.soundProvider.playRandomTune()
            weakSelf?.soundProvider.play(sfx: .start)
            weakSelf?.currentScore = 0
            weakSelf?.logoLabel?.fadeOut(for: 0.4)
            
            menu.fadeOut(for: 0.4,
                         completion: {
                            guard let strongSelf = weakSelf else { return }
                            
                            UILabel.spawnFloatingFadingLabels(toSuperview: strongSelf.view,
                                                              withTexts: [Constants.Text.startGameReadyText1,
                                                                          Constants.Text.startGameReadyText2,
                                                                          Constants.Text.startGameReadyText3]) {
                                weakSelf?.spawnGrid(in: .center)
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
