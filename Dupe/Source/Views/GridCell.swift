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
    @IBOutlet private weak var cornerHeightLayoutConstraint: NSLayoutConstraint?
    
    static let CellIdentifier = "GridCellIdentifier"
    static let NibName = "GridCell"
        
    private let baseColor: UIColor = UIColor.init(red: 61/255,
                                           green: 142/255,
                                           blue: 255/255,
                                           alpha: 1)
    private let activeColor: UIColor = .white
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
        
        square?.backgroundColor = baseColor
        cornerHeightLayoutConstraint?.constant = 0
    }
    
    // MARK: - Updating -
    
    func update(asSelected selected: Bool) {
        square?.backgroundColor = selected ? activeColor : baseColor
    }

}
