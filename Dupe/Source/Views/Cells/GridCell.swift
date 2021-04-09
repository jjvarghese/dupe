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
    
    @IBOutlet weak var brCorner: UIView?
    @IBOutlet weak var blCorner: UIView?
    @IBOutlet weak var trCorner: UIView?
    @IBOutlet weak var tlCorner: UIView?
    
    var shouldPulse: Bool = false
    var size: GridSize = .small
    var index: Int = 0
        
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isUserInteractionEnabled = true
        
        square?.backgroundColor = GameViewController.baseRubikColor
        
        styleCorners()
    }
    
    // MARK: - Updating -
    
    func update(asSelected selected: Bool) {
        let pulseDuration = 0.3
        
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            weakSelf?.layoutIfNeeded()

            UIView.animate(withDuration: pulseDuration,
                           animations: {
                            weakSelf?.square?.backgroundColor = selected ? GameViewController.activeRubikColor : GameViewController.baseRubikColor
            })
        }

        styleCorners()
    }
    
    // MARK: - Helper -
    
    private func styleCorners() {
        switch index {
        case 0:
            style(clearCorners: [.topLeft, .topRight, .bottomLeft],
                  standardCorners: [.bottomRight])
        case 1:
            style(clearCorners: [.topLeft, .topRight],
                  standardCorners: [.bottomRight, .bottomLeft])
        case 2:
            style(clearCorners: [.topLeft, .topRight],
                  standardCorners: [.bottomRight, .bottomLeft])
        case 3:
            style(clearCorners: [.topLeft, .topRight, .bottomRight],
                  standardCorners: [.bottomLeft])
        case 4:
            style(clearCorners: [.topLeft, .bottomLeft],
                  standardCorners: [.topRight, .bottomRight])
        case 5:
            style(clearCorners: [],
                  standardCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
        case 6:
            style(clearCorners: [],
                  standardCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
        case 7:
            style(clearCorners: [.topRight, .bottomRight],
                  standardCorners: [.topLeft, .bottomLeft])
        case 8:
            style(clearCorners: [.topLeft, .bottomLeft],
                  standardCorners: [.topRight, .bottomRight])
        case 9:
            style(clearCorners: [],
                  standardCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
        case 10:
            style(clearCorners: [],
                  standardCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight])
        case 11:
            style(clearCorners: [.topRight, .bottomRight],
                  standardCorners: [.topLeft, .bottomLeft])
        case 12:
            style(clearCorners: [.topLeft, .bottomLeft, .bottomRight],
                  standardCorners: [.topRight])
        case 13:
            style(clearCorners: [.bottomLeft, .bottomRight],
                  standardCorners: [.topLeft, .topRight])
        case 14:
            style(clearCorners: [.bottomLeft, .bottomRight],
                  standardCorners: [.topLeft, .topRight])
        case 15:
            style(clearCorners: [.bottomLeft, .bottomRight, .topRight],
                  standardCorners: [.topLeft])
        default:
            style(clearCorners: [],
                  standardCorners: [.topLeft, .topRight, .bottomRight, .bottomLeft])
        }
    }
    
    private func style(clearCorners: [Corner], standardCorners: [Corner]) {
        for corner in clearCorners {
            style(corner: corner,
                  asBlack: false)
        }
        
        for corner in standardCorners {
            style(corner: corner,
                  asBlack: true)
        }
    }
    
    private func style(corner: Corner,
                       asBlack: Bool) {
        guard let cornerView = cornerView(for: corner) else { return }
        
        cornerView.backgroundColor = asBlack ? .black : UIColor.background
    }
    
    private func cornerView(for corner: Corner) -> UIView? {
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
   
}
