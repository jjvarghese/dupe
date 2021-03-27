//
//  GameViewController+MenuDelegate.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension GameViewController: MenuDelegate {
    
    func menu(_ menu: Menu,
              selectedOption menuOption: MenuOption) {
        switch menuOption {
        case .start:
            handleStartPressed(menu: menu)
        case .about:
            handleAboutPressed()
        }
    }
    
    // MARK: - Private: Handling -
    
    private func handleStartPressed(menu: Menu) {
        bigGrid?.reset()
        soundProvider.playRandomTune()
        soundProvider.play(sfx: .start)
        scoreLabel?.isHidden = true
        currentScore = 0
                
        weak var weakSelf = self
        
        menu.fadeOut(for: 0.4,
                             completion: {
                                weakSelf?.spawnFloatingFadingLabels(withTexts: ["Ready...", "Set...", "DUPE!"], withCompletion: {
                                    weakSelf?.spawnGrid(in: .center)
                                })
        })
    }
    
    private func handleAboutPressed() {
        
    }
    
    
}
