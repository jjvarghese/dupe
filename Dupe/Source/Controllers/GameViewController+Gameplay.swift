//
//  GameViewController+Gameplay.swift
//  Dupe
//
//  Created by Joshua James on 27.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController {
    
    
    
    func triggerGameOver() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.session = nil
            self.soundProvider.play(sfx: .gameOver)
            self.soundProvider.stopAllTunes()
            self.logoLabel?.themeAsLogo()
            self.menu?.backgroundColor = UIColor.baseRubikColor
            self.bigGrid?.reset()

            UILabel.spawnFloatingFadingLabel(toSuperview: self.view,
                                             withText: Constants.Text.collisionText) {
                self.startNewRound()
            }
        }
    }
    
    func startNewRound() {
        menu?.alpha = 1.0
    }
    
    
    
    
    
}
