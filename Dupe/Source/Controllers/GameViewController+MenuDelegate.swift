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
            
            menu.fadeOut(for: 0.4,
                         completion: {
                            guard let strongSelf = weakSelf else { return }
                            
                            UILabel.spawnFloatingFadingLabels(toSuperview: strongSelf.view,
                                                              withTexts: ["Ready...", "Set...", "DUPE!"]) {
                                weakSelf?.spawnGrid(in: .center)
                            }
                         })
        }
    }
    
    private func handleAboutPressed() {
        notificationView?.popin(withText: """
        Dupe is a solo production,\n made with ❤️\n\n Sound effects and music obtained from\nhttps://www.zapsplat.com
        """)
    }
    
    private func handleHighScoresPressed() {
        let highScores = HighScores.getScores()
        
        var text = String("HIGH SCORES\n\n")
        
        var i = 1
        for highScore in highScores {
            text.append(String(format: "%d. %d\n", i, highScore))
            
            i = i + 1
        }
        
        if highScores.count == 0 {
            text.append("No scores yet!")
        }
        
        notificationView?.popin(withText: text)
    }
    
}
