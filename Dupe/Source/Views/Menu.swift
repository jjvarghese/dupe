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
    
    static let NibName = "Menu"
    
    var menuDelegate: MenuDelegate?
    
    // MARK: - Constructors -
    
    override init(frame: CGRect,
                  style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    // MARK: - Configuration -
    
    private func configure() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.baseRubikColor
        separatorStyle = .none
        
        configureRegistration()
    }
    
    private func configureRegistration() {
        let nib = UINib.init(nibName: Constants.NibNames.MenuCell,
                             bundle: nil)
        
        register(nib,
                 forCellReuseIdentifier: Constants.CellIdentifiers.MenuCell)
    }
            
}
