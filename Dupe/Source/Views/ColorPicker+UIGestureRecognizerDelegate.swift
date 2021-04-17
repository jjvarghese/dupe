//
//  ColorPicker+UIGestureRecognizerDelegate.swift
//  Dupe
//
//  Created by Joshua James on 17.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension ColorPicker: UIGestureRecognizerDelegate {
    
    @objc func didTap(touchGesture: UITapGestureRecognizer) {
        colorPickerDelegate?.colorPickerWasPressed(self)
    }
    
}
