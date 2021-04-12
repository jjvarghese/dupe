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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.menuDelegate?.menu(self,
                                    selectedOption: option)
        }
       
    }
    
}
