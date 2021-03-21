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
    
    func triggerMatch(forGrid grid: GridCollectionView?) {
        soundProvider.play(sfx: .matched)
        
        bigGrid?.reset()
        
        let numberOfPointsToGain = getNumberOfPointsToGain()
        
        spawnFloatingFadingLabel(withText: String(format: "%d", numberOfPointsToGain))
        
        currentScore += numberOfPointsToGain
        
        if currentTempo <= GameViewController.THRESHOLD_TEMPO_FOR_INSANITY && isInsaneMode == false {
            if Int.random(in: 0..<9) == 0 {
                isInsaneMode = true
            }
        }
        
        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            weakSelf?.release(grid: grid)
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
        smallGrid?.descentInProgress = false
        currentTempo = GameViewController.STARTING_TEMPO
    }
    
    func release(grid: GridCollectionView?) {
        guard let bigGrid = bigGrid else { return }

        var tempo = currentTempo
        
        if currentTempo > GameViewController.MAXIMUM_TEMPO { // Maximum speed - any faster, and it's too hard
            tempo -= GameViewController.INCREMENT_TEMPO
        }
        
        currentTempo = tempo
                
        grid?.startFalling(collisionGrid: bigGrid)
    }
    
    func startInsanityMode() {
        soundProvider.playRandomTune()
        
        leftGrid?.isHidden = false
        rightGrid?.isHidden = false
        
        bigGrid?.reloadData()
        smallGrid?.reloadData()
        rightGrid?.reloadData()
        leftGrid?.reloadData()
        
        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            weakSelf?.release(grid: weakSelf?.leftGrid)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            weakSelf?.release(grid: weakSelf?.rightGrid)
        }
        
        insanityTimer = Timer.scheduledTimer(timeInterval: GameViewController.INSANITY_MODE_DURATION,
                                             target: self,
                                             selector: #selector(switchOffInsanity),
                                             userInfo: nil,
                                             repeats: false)
      
        
    }
        
    func endInsanityMode() {
        insanityTimer = nil
                
        smallGrid?.descentInProgress = false
        
        leftGrid?.isHidden = true
        rightGrid?.isHidden = true
        leftGrid?.stop()
        rightGrid?.stop()
        
        release(grid: smallGrid)
        
        bigGrid?.reloadData()
        smallGrid?.reloadData()
    }
    
    // MARK: - Private -
    
    @objc private func switchOffInsanity() {
        isInsaneMode = false
    }
    
}
