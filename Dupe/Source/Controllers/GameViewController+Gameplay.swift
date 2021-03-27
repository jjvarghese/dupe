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
            let threshold = position == .center ? 0.0 : 0.05
            
            grid.startFalling(collisionGrid: bigGrid,
                                    withTempo: tempo + threshold)
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
        
        UILabel.spawnFloatingFadingLabel(toSuperview: view,
                                         withText: String(format: "%d", numberOfPointsToGain))
        
        currentScore += numberOfPointsToGain
        
        if tempo <= GameViewController.THRESHOLD_TEMPO_FOR_EXTRA_SPAWN {
            let randomNumber = Int.random(in: 0..<5)
            if randomNumber == 0 {
                Timer.scheduledTimer(timeInterval: 1.2,
                                     target: self,
                                     selector: #selector(spawnSideGrid),
                                     userInfo: nil,
                                     repeats: false)
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
        
        UILabel.spawnFloatingFadingLabel(toSuperview: view,
                                         withText: "BOOM!") {
            weakSelf?.startNewRound()
        }
    }
    
    func startNewRound() {
        tempo = GameViewController.STARTING_TEMPO
        menu?.alpha = 1.0
    }
    
    // MARK: - Private -
    
    @objc private func spawnSideGrid() {
        var hasExistingLeftGrid = false
        var hasExistingRightGrid = false
        
        for grid in grids {
            if grid.position == .left {
                hasExistingLeftGrid = true
            } else if grid.position == .right {
                hasExistingRightGrid = true
            }
        }
        
        if hasExistingRightGrid && hasExistingLeftGrid {
            return
        } else if hasExistingRightGrid {
            spawnGrid(in: .left)
        } else if hasExistingLeftGrid {
            spawnGrid(in: .right)
        } else {
            let coinFlip = Int.random(in: 0..<2)

            spawnGrid(in: coinFlip == 0 ? .left : .right)
        }
    }
}
