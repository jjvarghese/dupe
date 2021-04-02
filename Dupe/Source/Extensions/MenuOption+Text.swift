//
//  MenuOption+Text.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension MenuOption {
    
    func title() -> String {
        switch (self) {
        case .start:
            return "START"
        case .about:
            return "ABOUT"
        case .highScores:
            return "HIGH SCORES"
        }
    }
    
}
