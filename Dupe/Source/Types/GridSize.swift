//
//  GridSize.swift
//  Dupe
//
//  Created by Joshua James on 01.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

enum GridSize: Int {
    
    case small = 0
    
    case large
    
}

extension GridSize {
    
    var borderThickness: CGFloat {
        switch self {
        case .small:
            return 1.0
        case .large:
            return 3.0
        }
    }
    
}
