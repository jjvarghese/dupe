//
//  RubikColor.swift
//  Dupe
//
//  Created by Joshua James on 31.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

enum RubikColor: String, CaseIterable {
    
    case blue = "#426899"
    
    case yellow = "#FFC547"
    
    case red = "#BE2E36"
    
    case orange = "#FF7D3E"
            
}

extension RubikColor {
    
    static func getRandomRubikColor() -> RubikColor {
        let randomSelectionIndex = Int.random(in: 0..<RubikColor.allCases.count)
        let randomSelection = RubikColor.allCases[randomSelectionIndex]
        
        return randomSelection
    }
    
    func color() -> UIColor {
        let rubikColor = UIColor(withHex: rawValue)
        
        return rubikColor
    }
    
}
