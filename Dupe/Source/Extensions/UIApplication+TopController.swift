//
//  UIApplication+TopController.swift
//  Dupe
//
//  Created by Joshua James on 16.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    class func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        
        return keyWindow?.rootViewController
    }
    
}
