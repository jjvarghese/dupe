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
        guard let smallGrid = smallGrid else { return }
        
        soundProvider.play(sfx: .matched)
        
        bigGrid?.reset()
        smallGrid.randomise()
        
        let numberOfPointsToGain = getNumberOfPointsToGain()
        
        spawnFloatingFadingLabel(withText: String(format: "%d", numberOfPointsToGain))
        
        currentScore += numberOfPointsToGain
        
        if smallGrid.currentTempo <= GameViewController.THRESHOLD_TEMPO_FOR_INSANITY && isInsaneMode == false {
            if Int.random(in: 0..<9) == 0 {
                isInsaneMode = true
            }
        }
    }
    
    func getNumberOfPointsToGain() -> Int {
        guard let smallGrid = smallGrid else { return 0 }

        let baseline = 100
        let amountToSubtract = smallGrid.currentTempo * 100
        
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
        smallGrid?.descentInProgress = false
        smallGrid?.currentTempo = Grid.STARTING_TEMPO
    }
    
    func releaseNewSmallGrid() {
        guard let bigGrid = bigGrid,
              let smallGrid = smallGrid else { return }

        var tempo = smallGrid.currentTempo
        
        if smallGrid.currentTempo > Grid.MAXIMUM_TEMPO { // Maximum speed - any faster, and it's too hard
            tempo -= Grid.INCREMENT_TEMPO
        }
        
        smallGrid.currentTempo = tempo
                
        smallGrid.startFalling(collisionGrid: bigGrid,
                                withTempo: tempo)
    }
    
    func startInsanityMode() {
        soundProvider.playRandomTune()

        insanityTimer = Timer.scheduledTimer(timeInterval: GameViewController.INSANITY_MODE_DURATION,
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
