//
//  HighScores.swift
//  Dupe
//
//  Created by Joshua James on 02.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

class HighScores {
    
    private static let MAX_NUMBER_OF_SCORES = 5
    
    static func save(score: Int,
                     storage: UserDefaultsProtocol = UserDefaults.standard) {
        if var existingHighScores = storage.getObject(forKey: Constants.Keys.highScores) as? [Int] {
            if existingHighScores.count < MAX_NUMBER_OF_SCORES {
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
            
            storage.set(object: existingHighScores,
                        forKey: Constants.Keys.highScores)
        } else {
            let newHighScores = [score]
            
            storage.set(object: newHighScores,
                        forKey: Constants.Keys.highScores)
        }
    }
    
    static func getHighScoreText() -> String {
        let highScores = HighScores.getScores()
        
        var text = Constants.Text.highScoreTitle
        
        var i = 1
        for highScore in highScores {
            text.append(String(format: "%d. %d\n", i, highScore))
            
            i = i + 1
        }
        
        if highScores.count == 0 {
            text.append(Constants.Text.highScoreNoScores)
        }
        
        return text
    }
        
    static func getScores(storage: UserDefaultsProtocol = UserDefaults.standard) -> [Int] {
        let existingHighScores = storage.getObject(forKey: Constants.Keys.highScores) as? [Int]
        
        return existingHighScores?.sorted().reversed() ?? []
    }
    
}
