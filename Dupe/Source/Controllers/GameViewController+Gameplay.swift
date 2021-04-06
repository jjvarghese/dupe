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
            
            for grid in strongSelf.grids {
                if grid.position == position {
                    return
                }
            }
            
            let grid = Grid(withSize: .small)

            grid.position = position
            
            strongSelf.configure(grid: grid)
            strongSelf.grids.append(grid)
            strongSelf.view.addSubviewWithConstraints(subview: grid,
                                                      atPosition: position)
            
            grid.randomise()
                    
            if strongSelf.tempo > Constants.Values.maximumTempo { // Maximum speed - any faster, and it's too hard
                strongSelf.tempo -= Constants.Values.incrementTempo
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
            
            if strongSelf.tempo <= Constants.Values.thresholdTempoForExtraSpawns {
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
        let amountToSubtract = tempo * 500
        let positionModifier = matchedGrid.position == .center ? 0 : 100
        
        return (baseline - Int(amountToSubtract) + positionModifier)
    }
    
    func triggerGameOver() {
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            strongSelf.gameInProgress = false 
            strongSelf.soundProvider.play(sfx: .gameOver)
            strongSelf.soundProvider.stopAllTunes()
            strongSelf.logoLabel?.themeAsLogo()
            
            if strongSelf.currentScore > 0 {
                HighScores.save(score: strongSelf.currentScore)
            }
            
            strongSelf.menu?.backgroundColor = GameViewController.baseRubikColor
            strongSelf.bigGrid?.reset()
                                    
            for grid in strongSelf.grids {
                grid.removeFromSuperview()
            }
            
            UILabel.spawnFloatingFadingLabel(toSuperview: strongSelf.view,
                                             withText: Constants.Text.collisionText) {
                strongSelf.startNewRound()
                strongSelf.showScore()
            }
        }
    }
    
    func startNewRound() {
        menu?.alpha = 1.0
        
        weak var weakSelf = self
        
        determineInitialTempo { (initialTempo) in
            weakSelf?.tempo = initialTempo
        }
    }
    
    // MARK: - Private -
    
    private func determineInitialTempo(withCompletion completion: @escaping (TimeInterval) -> Void) {
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            let window = UIApplication.shared.windows.first
            let top = (window?.safeAreaInsets.top ?? 0) + Grid.START_POSITION
            let collisionPoint = strongSelf.bigGrid?.frame.origin.y ?? 0
            let bottom = top + (strongSelf.view.frame.size.width / 5)
            let distanceToFall = collisionPoint - bottom
            let timeToFall: CGFloat = Constants.Values.initialTimeToFall
            let pixelsPerSecond = distanceToFall / timeToFall
            let finalTempo = TimeInterval(1 / pixelsPerSecond)
            
            completion(finalTempo)
        }
    }
    
    private func showScore() {
        let scoreString = String(format: "%@%d",
                                 Constants.Text.gameOverHeadline,
                                 currentScore)
        
        notificationView?.popin(withText: scoreString)
    }
    
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
