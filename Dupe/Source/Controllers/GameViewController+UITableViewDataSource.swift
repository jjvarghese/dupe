//
//  GameViewController+UITableViewDataSource.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let menuCell = tableView.dequeueReusableCell(withIdentifier: MenuCell.CellIdentifier) as? MenuCell,
           let tableView = tableView as? Menu,
           let option = MenuOption(rawValue: indexPath.row) {
            menuCell.delegate = tableView
            
            menuCell.update(asMenuOption: option)
                
            return menuCell
        } else {
            return UITableViewCell()
        }
    }
    
}
