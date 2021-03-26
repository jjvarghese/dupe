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
    
    func spawnGrid(in position: Position) {
        let grid = Grid(frame: CGRect.zero,
                        collectionViewLayout: UICollectionViewFlowLayout.init())

        grid.position = position
        
        configure(grid: grid)
        
        grids.append(grid)
        
        view.addSubviewWithConstraints(subview: grid,
                                       atPosition: position)
        
        grid.randomise()
                
        if tempo > GameViewController.MAXIMUM_TEMPO { // Maximum speed - any faster, and it's too hard
            tempo -= GameViewController.INCREMENT_TEMPO
        }
                        
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
        
        if matchedGrid.position == .center {
            spawnGrid(in: .center)
        }
        
        let numberOfPointsToGain = getNumberOfPointsToGain(matchedGrid: matchedGrid)
        
        spawnFloatingFadingLabel(withText: String(format: "%d", numberOfPointsToGain))
        
        currentScore += numberOfPointsToGain
        
        if tempo <= GameViewController.THRESHOLD_TEMPO_FOR_EXTRA_SPAWN {
            let randomNumber = Int.random(in: 0..<9)
            if randomNumber == 0 {
                spawnGrid(in: .left)
            } else if randomNumber == 1 {
                spawnGrid(in: .right)
            }
        }
        
        matchedGrid.removeFromSuperview()
    }
    
    func getNumberOfPointsToGain(matchedGrid: Grid) -> Int {
        let baseline = 100
        let amountToSubtract = tempo * 100
        
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
    
}
