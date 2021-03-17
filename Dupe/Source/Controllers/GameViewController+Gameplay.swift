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
        
        spawnFloatingFadingLabel(withText: "50")
    }
    
    func triggerGameOver() {
        weak var weakSelf = self
        
        smallGrid?.randomise()
        smallGrid?.reset()
        smallGrid?.isHidden = true
        
        spawnFloatingFadingLabel(withText: "BOOM!") {
            weakSelf?.startNewRound()
        }
    }
    
    func startNewRound() {
        startButton?.alpha = 1.0
        
        descentInProgress = false
        
        currentTempo = GameViewController.STARTING_TEMPO
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
