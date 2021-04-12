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
            guard let self = self else { return }
            
            for grid in self.grids {
                if grid.position == position {
                    return
                }
            }
            
            let grid = Grid()
            
            grid.position = position
            
            self.configure(grid: grid)
            self.grids.append(grid)
            self.view.addSubviewWithConstraints(subview: grid,
                                                atPosition: position)
            
            grid.randomise()
            grid.accessibilityIdentifier = "SmallGrid"
            
            if self.tempo > Constants.Values.DifficultyThreshold.getMaximumTempo(forCurrentScore: self.currentScore) { // Maximum speed
                self.tempo -= Constants.Values.incrementTempo
            }
            
            if let bigGrid = self.bigGrid {
                let threshold = position == .center ? 0.0 : 0.01
                
                grid.startFalling(collisionGrid: bigGrid,
                                  withTempo: self.tempo + threshold)
            }
        }
    }
    
    func triggerMatch(matchedGrid: Grid) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.soundProvider.play(sfx: .matched)
            self.bigGrid?.reset()
            self.grids.removeAll { (onScreenGrid) -> Bool in
                return matchedGrid == onScreenGrid
            }
            
            if matchedGrid.position == .center {
                self.spawnGrid(in: .center)
            }
            
            let numberOfPointsToGain = self.getNumberOfPointsToGain(matchedGrid: matchedGrid)
            
            UILabel.spawnFloatingFadingLabel(toSuperview: self.view,
                                             withText: String(format: "%d", numberOfPointsToGain))
            
            self.currentScore += numberOfPointsToGain
            
            if self.tempo <= Constants.Values.thresholdTempoForExtraSpawns {
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
        let baseline = 100
        let amountToSubtract = tempo * 500
        let positionModifier = matchedGrid.position == .center ? 0 : 100
        
        return (baseline - Int(amountToSubtract) + positionModifier)
    }
    
    func triggerGameOver() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.gameInProgress = false
            self.soundProvider.play(sfx: .gameOver)
            self.soundProvider.stopAllTunes()
            self.logoLabel?.themeAsLogo()
            
            if self.currentScore > 0 {
                HighScores.save(score: self.currentScore)
            }
            
            self.menu?.backgroundColor = GameViewController.baseRubikColor
            self.bigGrid?.reset()
            
            for grid in self.grids {
                grid.removeFromSuperview()
            }
            
            UILabel.spawnFloatingFadingLabel(toSuperview: self.view,
                                             withText: Constants.Text.collisionText) {
                self.startNewRound()
                self.showScore()
            }
        }
    }
    
    func startNewRound() {
        menu?.alpha = 1.0
                
        determineInitialTempo { [weak self] (initialTempo) in
            self?.tempo = initialTempo
        }
    }
    
    // MARK: - Private -
    
    private func determineInitialTempo(withCompletion completion: @escaping (TimeInterval) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let window = UIApplication.shared.windows.first
            let top = (window?.safeAreaInsets.top ?? 0) + Grid.START_POSITION
            let collisionPoint = self.bigGrid?.frame.origin.y ?? 0
            let bottom = top + (self.view.frame.size.width / 5)
            let distanceToFall = collisionPoint - bottom
            let timeToFall: CGFloat = Constants.Values.initialTimeToFall
            let pixelsPerSecond = distanceToFall / timeToFall
            let finalTempo = TimeInterval(1 / pixelsPerSecond)
            
            completion(finalTempo)
        }
    }
    
    private func showScore() {
        let scoreString = String(format: "%@%d\n\n%@",
                                 Constants.Text.gameOverHeadline,
                                 currentScore,
                                 Constants.Text.ScoreJudgements.getJudgement(forScore: currentScore))
        
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
