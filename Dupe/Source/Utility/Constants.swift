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
        static let initialTimeToFall: CGFloat = 10
        static let matchDuration: TimeInterval = 0.3
        static let gridStartPosition: CGFloat = 0
        static let gridOverlapBuffer: CGFloat = 5
        static let initialSpawnTime: TimeInterval = 4
        static let spawnTimeReduction: TimeInterval = 0.05
        static let minimumSpawnTime: TimeInterval = 1.5
        static let maxNumberOfGridStacks: Int = 5
    }
    
    private init() {}
}
