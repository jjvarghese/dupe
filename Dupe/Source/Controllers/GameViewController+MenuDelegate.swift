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
        DispatchQueue.global().async { [weak self] in
            self?.soundProvider.play(sfx: .matched)

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
            guard let self = self else { return }
            
            self.session = GameSession(withDelegate: self)
            self.bigGrid.reset()
            self.soundProvider.play(sfx: .start)
            self.logoLabel.fade(out: true,
                                 for: 0.4)
        }
    }
    
    private func handleAboutPressed() {
        NotificationView.popin(withText: Constants.Text.aboutDescription,
                               withColor: bigGrid.rubikColor)
    }
    
    private func handleHighScoresPressed() {
        let text = HighScores.getHighScoreText()
        
        NotificationView.popin(withText: text,
                               withColor: bigGrid.rubikColor)
    }
    
}
