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
        bigGrid?.reset()
        smallGrid?.randomise()
        showScoreUp()
    }
    
    func triggerGameOver() {
        startNewRound()
    }
    
    func startNewRound() {
        descentInProgress = false
        
        smallGridTopConstraint?.constant = 14
        
        smallGrid?.updateConstraints()
        
        currentTempo = 0.2
    }
    
    func releaseNewSmallGrid() {
        var tempo = currentTempo
        
        if currentTempo > 0.02 { // Maximum speed - any faster, and it's too hard
            tempo -= 0.01
        }
        
        beginDescentOfSmallGrid(withDuration: tempo)
    }
    
    // MARK: - Private -
    
    private func showScoreUp() {
        guard let smallGrid = smallGrid else { return }
        
        var scoreUpLabel: UILabel? = UILabel(frame: CGRect(x: smallGrid.frame.origin.x + smallGrid.frame.size.width + 30,
                                                           y: smallGrid.frame.origin.y + (smallGrid.frame.size.height / 4),
                                                 width: 100,
                                                 height: 50))
        
        scoreUpLabel?.text = "50"
        scoreUpLabel?.textColor = .white
        scoreUpLabel?.font = UIFont(name: "AmericanTypewriter", size: 40)
        
        if let scoreUpLabel = scoreUpLabel {
            view.addSubview(scoreUpLabel)
        }
        
        let duration = 0.75
        
        scoreUpLabel?.floatUp(for: duration)
        scoreUpLabel?.fadeOut(for: duration)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            scoreUpLabel?.removeFromSuperview()
            scoreUpLabel = nil
        }
    }
    
}
