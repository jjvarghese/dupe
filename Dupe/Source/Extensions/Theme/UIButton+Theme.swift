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
        titleLabel?.font = UIFont(name: "8-bit",
                                          size: 37)
        setTitleColor(.white,
                      for: .normal)
    }
    
}
