//
//  UIColor+Theme.swift
//  Dupe
//
//  Created by Joshua James on 17.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Colours -
    
    static let background: UIColor = .white
    
    static let rubikBlue: UIColor = UIColor(withHex: RubikColor.blue.rawValue)
    
    static let rubikYellow: UIColor = UIColor(withHex: RubikColor.yellow.rawValue)
    
    static let rubikRed: UIColor = UIColor(withHex: RubikColor.red.rawValue)
    
    static let rubikOrange: UIColor = UIColor(withHex: RubikColor.orange.rawValue)
    
    static let rubikGreen: UIColor = UIColor(withHex: RubikColor.green.rawValue)
    
    static let rubikWhite: UIColor = UIColor(withHex: RubikColor.white.rawValue)
    
    // MARK: - Constructors -
    
    convenience init(withHex hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init()
            
            return
        }

        var rgbValue:UInt64 = 0
        
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
