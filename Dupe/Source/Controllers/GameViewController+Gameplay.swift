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
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            let grid = Grid(withSize: .small)

            grid.position = position
            
            strongSelf.configure(grid: grid)
            
            strongSelf.grids.append(grid)
            
            strongSelf.view.addSubviewWithConstraints(subview: grid,
                                           atPosition: position)
            
            grid.randomise()
                    
            if strongSelf.tempo > GameViewController.MAXIMUM_TEMPO { // Maximum speed - any faster, and it's too hard
                strongSelf.tempo -= GameViewController.INCREMENT_TEMPO
            }
                            
            if let bigGrid = strongSelf.bigGrid {
                let threshold = position == .center ? 0.0 : 0.05
                
                grid.startFalling(collisionGrid: bigGrid,
                                  withTempo: strongSelf.tempo + threshold)
            }
        }
    }
    
    func triggerMatch(matchedGrid: Grid) {
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            strongSelf.soundProvider.play(sfx: .matched)
            
            strongSelf.bigGrid?.reset()
            
            strongSelf.grids.removeAll { (onScreenGrid) -> Bool in
                return matchedGrid == onScreenGrid
            }
            
            if matchedGrid.position == .center {
                strongSelf.spawnGrid(in: .center)
            }
            
            let numberOfPointsToGain = strongSelf.getNumberOfPointsToGain(matchedGrid: matchedGrid)
            
            UILabel.spawnFloatingFadingLabel(toSuperview: strongSelf.view,
                                             withText: String(format: "%d", numberOfPointsToGain))
            
            strongSelf.currentScore += numberOfPointsToGain
            
            if strongSelf.tempo <= GameViewController.THRESHOLD_TEMPO_FOR_EXTRA_SPAWN {
                let randomNumber = Int.random(in: 0..<5)
                if randomNumber == 0 {
                    Timer.scheduledTimer(timeInterval: 1.2,
                                         target: self,
                                         selector: #selector(strongSelf.spawnSideGrid),
                                         userInfo: nil,
                                         repeats: false)
                }
            }
            
            matchedGrid.removeFromSuperview()
            
            strongSelf.rotateColors()
        }
    }
    
    func getNumberOfPointsToGain(matchedGrid: Grid) -> Int {
        let baseline = 100
        let amountToSubtract = tempo * 100
        
        return (baseline - Int(amountToSubtract))
    }
    
    func triggerGameOver() {
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            strongSelf.soundProvider.play(sfx: .gameOver)
            strongSelf.soundProvider.stopAllTunes()
            
            strongSelf.menu?.backgroundColor = GameViewController.baseRubikColor
            strongSelf.bigGrid?.reset()
                        
            strongSelf.scoreLabel?.isHidden = false
            
            for grid in strongSelf.grids {
                grid.removeFromSuperview()
            }
            
            UILabel.spawnFloatingFadingLabel(toSuperview: strongSelf.view,
                                             withText: "BOOM!") {
                strongSelf.startNewRound()
            }
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
    
    private func rotateColors() {
        GameViewController.baseRubikColor = RubikColor.getRandomRubikColor()

        bigGrid?.reloadData()
        
        for grid in grids {
            grid.reloadData()
        }
    }

}
