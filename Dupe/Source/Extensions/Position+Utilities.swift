//
//  Position+Utilities.swift
//  Dupe
//
//  Created by Joshua James on 16.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension Position {
    
    static func random() -> Position {
        let randomSelection = Int.random(in: 0..<Position.allCases.count)

        return Position(rawValue: randomSelection) ?? .innerLeft
    }
    
    func getXPositionOffset() -> CGFloat {
        let innerThreshold: CGFloat = 14
        let outerThreshold: CGFloat = 98
        
        switch self {
        case .innerLeft:
            return innerThreshold
        case .outerLeft:
            return outerThreshold
        case .innerRight:
            return -innerThreshold
        case .outerRight:
            return -outerThreshold
        }
    }
    
}
