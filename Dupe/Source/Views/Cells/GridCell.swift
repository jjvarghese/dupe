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
    
    @IBOutlet weak var squareTopConstraint: NSLayoutConstraint?
    @IBOutlet weak var squareBottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var squareLeadingConstraint: NSLayoutConstraint?
    @IBOutlet weak var squareTrailingConstraint: NSLayoutConstraint?
    
    @IBOutlet private weak var trCorner: UIView?
    @IBOutlet private weak var blCorner: UIView?
    @IBOutlet private weak var brCorner: UIView?
    @IBOutlet private weak var tlCorner: UIView?
    @IBOutlet private weak var square: UIView?

    var shouldPulse: Bool = false
    var shouldRemoveCorners: Bool = false
            
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
        
        square?.backgroundColor = GameViewController.baseRubikColor
        
        configureSubviews()
    }
    
    // MARK: - Updating -
    
    func update(asSelected selected: Bool,
                corner: Corner?,
                withBorderWidth borderWidth: CGFloat = 3.0) {
        square?.backgroundColor = selected ? GameViewController.activeRubikColor : GameViewController.baseRubikColor
        
        if selected && shouldPulse {
            pulse()
        }
        
        square?.layer.borderWidth = borderWidth
        square?.layer.borderColor = Grid.BORDER_COLOR.cgColor

        
//        styleAsCornerSquare(corner: corner)
    }
    
    // MARK: - Corner Styling -
    
    private func styleAsCornerSquare(corner: Corner?) {
//        trCorner?.backgroundColor = Grid.BORDER_COLOR
//        tlCorner?.backgroundColor = Grid.BORDER_COLOR
//        brCorner?.backgroundColor = Grid.BORDER_COLOR
//        blCorner?.backgroundColor = Grid.BORDER_COLOR
//        
//        guard let corner = corner else { return }
//        
//        let chosenCorner = getCornerView(forCorner: corner)
//        
//        chosenCorner?.backgroundColor = UIColor.background
    }
    
    private func getCornerView(forCorner corner: Corner) -> UIView? {
        switch corner {
        case .topLeft:
            return tlCorner
        case .topRight:
            return trCorner
        case .bottomLeft:
            return blCorner
        case .bottomRight:
            return brCorner
        }
    }
    
    // MARK: - Configuration -
    
    private func configureSubviews() {
        configureCorners()
    }
    
    private func configureCorners() {
        trCorner?.backgroundColor = Grid.BORDER_COLOR
        tlCorner?.backgroundColor = Grid.BORDER_COLOR
        brCorner?.backgroundColor = Grid.BORDER_COLOR
        blCorner?.backgroundColor = Grid.BORDER_COLOR
        
    }
   
}
