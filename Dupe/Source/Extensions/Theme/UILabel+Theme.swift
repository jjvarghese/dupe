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
    
    func theme(withSize size: CGFloat = 20) {
        backgroundColor = .clear
        textColor = UIColor.textColor
        font = UIFont(name: "PressStart2P-Regular",
                        size: size)
        textAlignment = .center
    }
    
    func themeAsLogo() {
        backgroundColor = .clear
        textColor = GameViewController.baseRubikColor
        font = UIFont(name: "8-bit",
                        size: 70)
        textAlignment = .center
        alpha = 1
        bob()
    }
    
}
