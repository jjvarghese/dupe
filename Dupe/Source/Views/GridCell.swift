//
//  GridCell.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {

    @IBOutlet private weak var square: UIView?
    
    static let CellIdentifier = "GridCellIdentifier"
    static let NibName = "GridCell"
    
    var isBeingTouchDragged: Bool = false
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true

    }
    
    // MARK: - Updating -
    
    func update(asSelected selected: Bool) {
        square?.backgroundColor = selected ? .white : .blue
    }

}
