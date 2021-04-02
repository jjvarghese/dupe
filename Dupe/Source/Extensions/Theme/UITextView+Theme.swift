//
//  UITextView+Theme.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    
    func theme() {
        backgroundColor = .clear
        textColor = UIColor.textColor
        font = UIFont(name: "8-bit",
                        size: 20)
        textAlignment = .center
    }
    
}
