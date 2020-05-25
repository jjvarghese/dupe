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
    @IBOutlet private weak var squareTopConstraint: NSLayoutConstraint?
    @IBOutlet private weak var squareBottomConstraint: NSLayoutConstraint?
    @IBOutlet private weak var squareLeadingConstraint: NSLayoutConstraint?
    @IBOutlet private weak var squareTrailingConstraint: NSLayoutConstraint?
    
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
        cornerHeightLayoutConstraint?.constant = 1
    }
    
    // MARK: - Updating -
    
    func update(asSelected selected: Bool) {
        square?.backgroundColor = selected ? activeColor : baseColor
        
        if selected {
            pulse()
        }
    }
    
    // MARK: - Animation -
    
    private func pulse() {
        let pulseDuration = 0.3
        
        weak var weakSelf = self
        
        adjustSquareSize(amount: -5)

        UIView.animate(withDuration: pulseDuration,
                       animations: {
                        weakSelf?.layoutIfNeeded()
        }) { (finished) in
            if finished {
                weakSelf?.adjustSquareSize(amount: 0)

                UIView.animate(withDuration: pulseDuration) {
                    weakSelf?.layoutIfNeeded()
                }
            }
        }
    }
    
    private func adjustSquareSize(amount: CGFloat) {
        squareTopConstraint?.constant = amount
        squareBottomConstraint?.constant = amount
        squareLeadingConstraint?.constant = amount
        squareTrailingConstraint?.constant = amount
    }

}
