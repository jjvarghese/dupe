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
        
        let numberOfPointsToGain = getNumberOfPointsToGain()
        
        spawnFloatingFadingLabel(withText: String(format: "%d", numberOfPointsToGain))
        
        currentScore += numberOfPointsToGain
    }
    
    func getNumberOfPointsToGain() -> Int {
        let baseline = 100
        let amountToSubtract = currentTempo * 100
        
        return (baseline - Int(amountToSubtract))
    }
    
    func triggerGameOver() {
        weak var weakSelf = self
        
        scoreLabel?.isHidden = false
        smallGrid?.randomise()
        smallGrid?.reset()
        
        spawnFloatingFadingLabel(withText: "BOOM!") {
            weakSelf?.startNewRound()
        }
    }
    
    func startNewRound() {
        smallGrid?.isHidden = true
        startButton?.alpha = 1.0
        descentInProgress = false
        currentTempo = GameViewController.STARTING_TEMPO
    }
    
    func releaseNewSmallGrid() {
        var tempo = currentTempo
        
        if currentTempo > GameViewController.MAXIMUM_TEMPO { // Maximum speed - any faster, and it's too hard
            tempo -= GameViewController.INCREMENT_TEMPO
        }
        
        beginDescentOfSmallGrid(withDuration: tempo)
    }
    
}
