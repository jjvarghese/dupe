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
    
    func spawnGrid() {
        let grid = Grid(frame: CGRect.zero,
                        collectionViewLayout: UICollectionViewFlowLayout.init())

        configure(grid: grid)
        
        grids.append(grid)
        
        view.addSubviewWithConstraints(subview: grid)
        
        grid.randomise()
        
        var tempo = grid.currentTempo
        
        if grid.currentTempo > Grid.MAXIMUM_TEMPO { // Maximum speed - any faster, and it's too hard
            tempo -= Grid.INCREMENT_TEMPO
        }
        
        grid.currentTempo = tempo
                
        if let bigGrid = bigGrid {
            grid.startFalling(collisionGrid: bigGrid,
                                    withTempo: tempo)
        }
    }
    
    func triggerMatch(matchedGrid: Grid) {        
        soundProvider.play(sfx: .matched)
        
        bigGrid?.reset()
        
        grids.removeAll { (onScreenGrid) -> Bool in
            return matchedGrid == onScreenGrid
        }
        
        spawnGrid()
        
        let numberOfPointsToGain = getNumberOfPointsToGain(matchedGrid: matchedGrid)
        
        spawnFloatingFadingLabel(withText: String(format: "%d", numberOfPointsToGain))
        
        currentScore += numberOfPointsToGain
        
        if matchedGrid.currentTempo <= GameViewController.THRESHOLD_TEMPO_FOR_INSANITY && isInsaneMode == false {
            if Int.random(in: 0..<9) == 0 {
                isInsaneMode = true
            }
        }
        
        matchedGrid.removeFromSuperview()
    }
    
    func getNumberOfPointsToGain(matchedGrid: Grid) -> Int {
        let baseline = 100
        let amountToSubtract = matchedGrid.currentTempo * 100
        
        return (baseline - Int(amountToSubtract))
    }
    
    func triggerGameOver() {
        soundProvider.play(sfx: .gameOver)
        soundProvider.stopAllTunes()
        
        weak var weakSelf = self
        
        scoreLabel?.isHidden = false
        
        for grid in grids {
            grid.removeFromSuperview()
        }
        
        spawnFloatingFadingLabel(withText: "BOOM!") {
            weakSelf?.startNewRound()
        }
    }
    
    func startNewRound() {
        startButton?.alpha = 1.0
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
    }
    
}
