//
//  HighScores.swift
//  Dupe
//
//  Created by Joshua James on 02.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

class HighScores {
    
    private static let HIGH_SCORES_KEY = "HIGH_SCORES"
    
    static func save(score: Int) {
        if var existingHighScores = UserDefaults.standard.object(forKey: HIGH_SCORES_KEY) as? [Int] {
            if existingHighScores.count < 10 {
                existingHighScores.append(score)
            } else {
                if let lowestScore = existingHighScores.min() {
                    if score > lowestScore {
                        existingHighScores.removeAll { (element) -> Bool in
                            return element == lowestScore
                        }
                        
                        existingHighScores.append(score)
                    }
                }
            }
            
            UserDefaults.standard.setValue(existingHighScores,
                                           forKey: HIGH_SCORES_KEY)
        } else {
            let newHighScores = [score]
            
            UserDefaults.standard.setValue(newHighScores,
                                           forKey: HIGH_SCORES_KEY)
        }
    }
    
    static func getScores() -> [Int] {
        let existingHighScores = UserDefaults.standard.object(forKey: HIGH_SCORES_KEY) as? [Int]
        
        return existingHighScores?.sorted().reversed() ?? []
    }
    
}
