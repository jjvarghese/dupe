//
//  NSLayoutConstraint+ConstraintDetection.swift
//  Dupe
//
//  Created by Joshua James on 21.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    func isTopConstraint(forObject object: AnyObject) -> Bool {
        guard let firstItem = firstItem,
              let secondItem = secondItem else { return false }
        
        return (firstItem.isEqual(object) && firstAttribute == .top) || (secondItem.isEqual(object) && secondAttribute == .top)
    }
    
}
