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
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let session = self.session else { return }
            
            for grid in session.grids {
                if grid.position == position {
                    return
                }
            }
            
            let grid = Grid()
            
            grid.position = position
            
            self.configure(grid: grid)
            session.grids.append(grid)
            self.view.addSubviewWithConstraints(subview: grid,
                                                atPosition: position)
            
            grid.randomise()
            grid.accessibilityIdentifier = "SmallGrid"
            
            if session.tempo > Constants.Values.DifficultyThreshold.getMaximumTempo(forCurrentScore: session.currentScore) { // Maximum speed
                session.tempo -= Constants.Values.incrementTempo
            }
            
            if let bigGrid = self.bigGrid {
                let threshold = position == .center ? 0.0 : 0.01
                
                grid.startFalling(collisionGrid: bigGrid,
                                  withTempo: session.tempo + threshold)
            }
        }
    }
    
    func triggerMatch(matchedGrid: Grid) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let session = self.session else { return }
            
            self.soundProvider.play(sfx: .matched)
            self.bigGrid?.reset()
            session.grids.removeAll { (onScreenGrid) -> Bool in
                return matchedGrid == onScreenGrid
            }
            
            if matchedGrid.position == .center {
                self.spawnGrid(in: .center)
            }
            
            let numberOfPointsToGain = self.getNumberOfPointsToGain(matchedGrid: matchedGrid)
            
            UILabel.spawnFloatingFadingLabel(toSuperview: self.view,
                                             withText: String(format: "%d", numberOfPointsToGain))
            
            session.currentScore += numberOfPointsToGain
            
            if session.tempo <= Constants.Values.thresholdTempoForExtraSpawns {
                let randomNumber = Int.random(in: 0..<5)
                
                if randomNumber == 0 {
                    Timer.scheduledTimer(timeInterval: Constants.Values.sideGridSpawnDelay,
                                         target: self,
                                         selector: #selector(self.spawnSideGrid),
                                         userInfo: nil,
                                         repeats: false)
                }
            }
            
            matchedGrid.removeFromSuperview()
            
            self.rotateColors()
        }
    }
    
    func getNumberOfPointsToGain(matchedGrid: Grid) -> Int {
        guard let session = session else { return 0 }
        
        let baseline = 100
        let amountToSubtract = session.tempo * 500
        let positionModifier = matchedGrid.position == .center ? 0 : 100
        
        return (baseline - Int(amountToSubtract) + positionModifier)
    }
    
    func triggerGameOver() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.showScore()
            self.session = nil
            self.soundProvider.play(sfx: .gameOver)
            self.soundProvider.stopAllTunes()
            self.logoLabel?.themeAsLogo()
            self.menu?.backgroundColor = GameViewController.baseRubikColor
            self.bigGrid?.reset()

            UILabel.spawnFloatingFadingLabel(toSuperview: self.view,
                                             withText: Constants.Text.collisionText) {
                self.startNewRound()
            }
        }
    }
    
    func startNewRound() {
        menu?.alpha = 1.0
    }
    
    
    private func showScore() {
        guard let session = session else { return }
        
        // TODO: Move to GameSession, make NotificationView static
        let scoreString = String(format: "%@%d\n\n%@",
                                 Constants.Text.gameOverHeadline,
                                 session.currentScore,
                                 Constants.Text.ScoreJudgements.getJudgement(forScore: session.currentScore))
        
        notificationView?.popin(withText: scoreString)
    }
    
    @objc private func spawnSideGrid() {
        guard let session = session else { return }
        
        var hasExistingLeftGrid = false
        var hasExistingRightGrid = false
        
        for grid in session.grids {
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
        guard let session = session else { return }

        GameViewController.baseRubikColor = RubikColor.getRandomRubikColor()
        
        bigGrid?.reloadData()
        
        for grid in session.grids {
            grid.reloadData()
        }
    }
    
}
