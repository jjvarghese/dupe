//
//  [NSLayoutConstraint]+Operations.swift
//  Dupe
//
//  Created by Joshua James on 21.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element == NSLayoutConstraint {

    func getTopConstraint(forObject object: AnyObject) -> NSLayoutConstraint? {
        for constraint in self {
            if constraint.isTopConstraint(forObject: object) {
                return constraint
            }
        }
        
        return nil
    }
    
}
