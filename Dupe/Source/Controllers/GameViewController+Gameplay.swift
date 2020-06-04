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
    
    func triggerMatch() {
        bigGrid?.reset()
        smallGrid?.randomise()
        
        guard let smallGrid = smallGrid else { return }

        spawnFloatingFadingLabel(atX: smallGrid.frame.origin.x + smallGrid.frame.size.width + 30,
                                 atY: smallGrid.frame.origin.y + (smallGrid.frame.size.height / 4),
                                 withText: "50")
    }
    
    func triggerGameOver() {
        startNewRound()
    }
    
    func startNewRound() {
        descentInProgress = false
        
        smallGridTopConstraint?.constant = 14
        
        smallGrid?.updateConstraints()
        
        currentTempo = 0.2
        
        gameInProgress = true
                                                                            
        smallGrid?.randomise()
        
        beginDescentOfSmallGrid(withDuration: currentTempo)
    }
    
    func releaseNewSmallGrid() {
        var tempo = currentTempo
        
        if currentTempo > 0.02 { // Maximum speed - any faster, and it's too hard
            tempo -= 0.01
        }
        
        beginDescentOfSmallGrid(withDuration: tempo)
    }
    
    // MARK: - Private -
    
    
    
}
