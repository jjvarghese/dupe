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
    
    func theme(withSize size: TextSize = .medium) {
        backgroundColor = .clear
        textColor = UIColor.text
        font = UIFont(name: "PressStart2P-Regular",
                        size: TextSize.size(textSize: size))
        textAlignment = .center
    }
    
    func themeAsLogo() {
        backgroundColor = .clear
        textColor = GameViewController.baseRubikColor
        font = UIFont(name: "8-bit",
                        size: TextSize.size(textSize: .large))
        textAlignment = .center
        alpha = 1
        bob()
    }
    
}
