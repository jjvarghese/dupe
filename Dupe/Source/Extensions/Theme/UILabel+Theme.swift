//
//  UILabel+Theme.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func theme(withSize size: CGFloat = 37) {
        backgroundColor = .clear
        textColor = UIColor.textColor
        font = UIFont(name: "8-bit",
                        size: size)
        textAlignment = .center
    }
    
}
