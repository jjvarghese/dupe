//
//  Menu.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

protocol MenuDelegate {
    
    func menu(_ menu: Menu, selectedOption menuOption: MenuOption)
    
}

class Menu: UITableView {
    
    var menuDelegate: MenuDelegate?
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
        backgroundColor = GameViewController.baseRubikColor
        separatorStyle = .none
        
        configureRegistration()
    }
    
    // MARK: - Configuration -
    
    private func configureRegistration() {
        let nib = UINib.init(nibName: MenuCell.NibName,
                             bundle: nil)
        
        register(nib,
                 forCellReuseIdentifier: MenuCell.CellIdentifier)
    }
            
}
