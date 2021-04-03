//
//  UIDevice+Detection.swift
//  Dupe
//
//  Created by Joshua James on 03.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {

    var hasNotch: Bool {
        guard #available(iOS 11.0, *),
              let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
    
}
