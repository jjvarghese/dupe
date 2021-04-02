//
//  GameViewController+UITableViewDelegate.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let bigGrid = bigGrid else { return 0 }
        
        let numberOfElements: CGFloat = CGFloat(tableView.numberOfRows(inSection: 0))
        
        return (bigGrid.frame.size.height / numberOfElements) - 12
    }
    
}
