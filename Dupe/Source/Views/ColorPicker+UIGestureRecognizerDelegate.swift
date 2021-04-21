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
        delegate?.colorPickerWasPressed(self)
        
        self.animate(withAnimation: .squeeze)
    }
    
}
