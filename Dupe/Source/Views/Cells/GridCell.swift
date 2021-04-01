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
    var size: GridSize = .small
        
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
        
        square?.backgroundColor = GameViewController.baseRubikColor
        
        resize()
    }
    
    // MARK: - Updating -
    
    func update(asSelected selected: Bool) {
        resize()

        square?.backgroundColor = selected ? GameViewController.activeRubikColor : GameViewController.baseRubikColor
        
        if selected && shouldPulse {
            pulse()
        }
    }
    
    // MARK: - Helper -
    
    private func resize() {
        weak var weakSelf = self

        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            strongSelf.squareTopConstraint?.constant = strongSelf.size.borderThickness
            strongSelf.squareBottomConstraint?.constant = strongSelf.size.borderThickness
            strongSelf.squareLeadingConstraint?.constant = strongSelf.size.borderThickness
            strongSelf.squareTrailingConstraint?.constant = strongSelf.size.borderThickness
            strongSelf.cornerDimensionConstraint?.constant = strongSelf.size.borderThickness * 3
            strongSelf.innerCornerDimension?.constant = strongSelf.size.borderThickness * 2
        }
    }
   
}
