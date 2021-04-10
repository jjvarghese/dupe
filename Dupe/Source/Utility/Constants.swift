//
//  Constants.swift
//  Dupe
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Keys {
        static let highScores = "highScores"
    }
    
    struct Menu {
        static let start = "START"
        static let about = "ABOUT"
        static let highScores = "SCORE"
    }
    
    struct Text {
        static let startGameReadyText1 = "Ready..."
        static let startGameReadyText2 = "Set..."
        static let startGameReadyText3 = "DUPE!"
        static let aboutDescription = """
        Dupe is a solo production,\n made with ❤️\n\n Sound effects and music obtained from\nwww.zapsplat.com
        """
        static let highScoreTitle = "HIGH SCORES\n\n"
        static let highScoreNoScores = "No scores yet!"
        static let collisionText = "BOOM!"
        static let gameOverHeadline = "GAME OVER\n\nYou achieved a score of\n\n"
        
        enum ScoreJudgements: String, CaseIterable {
            case none = "Tip: Match the falling grid's pattern on the bottom grid."
            case a = "Are you even trying?"
            case b = "You can do better than that!"
            case c = "Not a bad effort."
            case d = "Pretty good."
            case e = "Pretty impressive."
            case f = "Wow, you're good at this!"
            case g = "Exceptional."
            case h = "Unbelievable!"
            case i = "Absolutely pro."
            
            static func getJudgement(forScore score: Int) -> String {
                let threshold = 1000
                var scoreCheck = 0
                
                for judgement in ScoreJudgements.allCases {
                    if score <= scoreCheck {
                        return judgement.rawValue
                    }
                    
                    scoreCheck += threshold
                }
                
                return ScoreJudgements.allCases.last?.rawValue ?? ""
            }
        }
    }
    
    struct NibNames {
        static let GridCell = "GridCell"
        static let MenuCell = "MenuCell"
        static let NotificationView = "NotificationView"
    }
    
    struct CellIdentifiers {
        static let GridCell = "GridCellIdentifier"
        static let MenuCell = "MenuCellIdentifier"
    }
    
    struct Values {
        static let initialTimeToFall: CGFloat = 30
        static let incrementTempo: TimeInterval = 0.01
        static let thresholdTempoForExtraSpawns: TimeInterval = 0.1
        static let sideGridSpawnDelay: TimeInterval = 1.2
        
        enum DifficultyThreshold: TimeInterval, CaseIterable {
            case easy = 0.04
            case medium = 0.03
            case hard = 0.02
            case insane = 0.01
            case legendary = 0.005
            
            static func getMaximumTempo(forCurrentScore score: Int) -> TimeInterval {
                let threshold = 1000
                var scoreCheck = 0
                
                for difficulty in DifficultyThreshold.allCases {
                    if score <= scoreCheck {
                        return difficulty.rawValue
                    }
                    
                    scoreCheck += threshold
                }
                
                return DifficultyThreshold.allCases.last?.rawValue ?? DifficultyThreshold.legendary.rawValue
            }
        }
    }
    
    private init() {}
}
