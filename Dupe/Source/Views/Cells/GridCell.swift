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
    @IBOutlet weak var cornerDimensionConstraint: NSLayoutConstraint?
    @IBOutlet weak var innerCornerDimension: NSLayoutConstraint?
    
    var shouldPulse: Bool = false
    var borderThickness: CGFloat = 3.0
        
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
        
        square?.backgroundColor = UIColor.base
        
        resize()
    }
    
    // MARK: - Updating -
    
    func update(asSelected selected: Bool) {
        resize()

        square?.backgroundColor = selected ? UIColor.active : UIColor.base
        
        if selected && shouldPulse {
            pulse()
        }
    }
    
    // MARK: - Helper -
    
    private func resize() {
        weak var weakSelf = self

        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            strongSelf.squareTopConstraint?.constant = strongSelf.borderThickness
            strongSelf.squareBottomConstraint?.constant = strongSelf.borderThickness
            strongSelf.squareLeadingConstraint?.constant = strongSelf.borderThickness
            strongSelf.squareTrailingConstraint?.constant = strongSelf.borderThickness
            strongSelf.cornerDimensionConstraint?.constant = strongSelf.borderThickness * 3
            strongSelf.innerCornerDimension?.constant = strongSelf.borderThickness * 2
        }
    }
   
}
