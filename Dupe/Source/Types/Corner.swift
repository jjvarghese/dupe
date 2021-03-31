//
//  Corner.swift
//  Dupe
//
//  Created by Joshua James on 30.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

enum Corner: Int {
    
    case topLeft = 0
    
    case topRight
    
    case bottomLeft
    
    case bottomRight
    
}

extension Corner {
    
    static func getCorner(forIndexPath indexPath: IndexPath) -> Corner? {
        if indexPath.row == 0 {
            return .topLeft
        } else if indexPath.row == 3 {
            return .topRight
        } else if indexPath.row == 12 {
            return .bottomLeft
        } else if indexPath.row == 15 {
            return .bottomRight
        } else {
            return nil
        }
    }
    
}
