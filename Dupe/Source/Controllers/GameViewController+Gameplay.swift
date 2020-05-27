//
//  GameViewController+Gameplay.swift
//  Dupe
//
//  Created by Joshua James on 27.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import Foundation

extension GameViewController {
    
    func triggerMatch() {
        bigGrid?.reset()
        smallGrid?.randomise()
    }
    
    func triggerGameOver() {
        startNewRound()
    }
    
    func startNewRound() {
        descentInProgress = false
        
        smallGridTopConstraint?.constant = 14
        
        smallGrid?.updateConstraints()
        
        currentTempo = 0.2
    }
    
    func releaseNewSmallGrid() {
        var tempo = currentTempo
        
        if currentTempo > 0.02 { // Maximum speed - any faster, and it's too hard
            tempo -= 0.01
        }
        
        beginDescentOfSmallGrid(withDuration: tempo)
        
        smallGrid?.isHidden = false
    }
    
}
