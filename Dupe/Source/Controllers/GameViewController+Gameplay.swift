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
        soundProvider.play(sfx: .matched)
        
        bigGrid?.reset()
        smallGrid?.randomise()
        
        let numberOfPointsToGain = getNumberOfPointsToGain()
        
        spawnFloatingFadingLabel(withText: String(format: "%d", numberOfPointsToGain))
        
        currentScore += numberOfPointsToGain
        
        if currentTempo <= GameViewController.THRESHOLD_TEMPO_FOR_INSANITY {
            if Int.random(in: 0..<9) == 0 {
                isInsaneMode = true
            }
        }
    }
    
    func getNumberOfPointsToGain() -> Int {
        let baseline = 100
        let amountToSubtract = currentTempo * 100
        
        return (baseline - Int(amountToSubtract))
    }
    
    func triggerGameOver() {
        soundProvider.play(sfx: .gameOver)
        soundProvider.stopAllTunes()
        
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
    
    func startInsanityMode() {        
        insanityTimer = Timer.scheduledTimer(timeInterval: 5.0,
                                             target: self,
                                             selector: #selector(endInsanityMode),
                                             userInfo: nil,
                                             repeats: false )
    }
        
    @objc func endInsanityMode() {
        insanityTimer = nil
        
        isInsaneMode = false
        
        releaseNewSmallGrid()
    }
    
}
