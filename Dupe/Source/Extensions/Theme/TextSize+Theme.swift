//
//  TextSize+Theme.swift
//  Dupe
//
//  Created by Joshua James on 09.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension TextSize {
    
    static func size(textSize: TextSize) -> CGFloat {
        let height = UIScreen.main.bounds.size.height
        
        let baseSize: CGFloat = textSize.getBaseSize()
        
        if height < 580 {
            return baseSize
        } else if height < 680 {
            return baseSize + 5
        } else if height < 780 {
            return baseSize + 10
        } else if height < 880 {
            return baseSize + 15
        } else {
            return baseSize + 20
        }
    }
    
    // MARK: - Private -
    
    private func getBaseSize() -> CGFloat {
        switch self {
        case .small:
            return 12
        case .medium:
            return 20
        case .large:
            return 70
        }
    }

}
