//
//  Menu+MenuCellDelegate.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension Menu: MenuCellDelegate {
    
    func menuCellSelectedOption(_ cell: MenuCell,
                                option: MenuOption) {
        menuDelegate?.menu(self,
                           selectedOption: option)
    }
    
}
