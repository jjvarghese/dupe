//
//  GameSession+ScoreKeeping.swift
//  Dupe
//
//  Created by Joshua James on 15.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension GameSession {
    
    func getNumberOfPointsToGain(matchedGrid: Grid) -> Int {
        let baseline = 100
        let amountToSubtract = tempo * 500
        let positionModifier = matchedGrid.position == .center ? 0 : 100
        
        return (baseline - Int(amountToSubtract) + positionModifier)
    }
    
}
