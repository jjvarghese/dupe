//
//  GridCell.swift
//  Dupe
//
//  Created by Joshua James on 19.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {

    static let CellIdentifier = "GridCellIdentifier"
    static let NibName = "GridCell"
    
    @IBOutlet private weak var square: UIView?
    @IBOutlet weak var squareTopConstraint: NSLayoutConstraint?
    @IBOutlet weak var squareBottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var squareLeadingConstraint: NSLayoutConstraint?
    @IBOutlet weak var squareTrailingConstraint: NSLayoutConstraint?

    var shouldPulse: Bool = false
        
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
        
        square?.backgroundColor = UIColor.base
    }
    
    // MARK: - Updating -
    
    func update(asSelected selected: Bool) {
        square?.backgroundColor = selected ? UIColor.active : UIColor.base
        
        if selected && shouldPulse {
            pulse()
        }
    }
   
}
