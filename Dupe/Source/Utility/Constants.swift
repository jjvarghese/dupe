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
        static let initialTimeToFall: CGFloat = 15
        static let maximumTempo: TimeInterval = 0.02
        static let incrementTempo: TimeInterval = 0.01
        static let thresholdTempoForExtraSpawns: TimeInterval = 0.1
    }
    
    private init() {}
}
