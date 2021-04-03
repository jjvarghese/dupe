//
//  UIButton+Theme.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func theme() {
        backgroundColor = .clear
        titleLabel?.font = UIFont(name: "PressStart2P-Regular",
                                          size: 20)
        setTitleColor(UIColor.background,
                      for: .normal)
    }
    
}
