//
//  GameViewController+ColorPickerDelegate.swift
//  Dupe
//
//  Created by Joshua James on 17.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension GameViewController: ColorPickerDelegate {
    
    func colorPickerWasPressed(_ colorPicker: ColorPicker) {
        guard let colorPickerColor = colorPicker.rubikColor else { return }
        
        bigGrid?.rubikColor = colorPickerColor
        
        let coinFlip = Int.random(in: 0...1)
        
        bigGrid?.reset(withAnimation: coinFlip == 0 ? .flipX : .flipY)
    }
    
}
