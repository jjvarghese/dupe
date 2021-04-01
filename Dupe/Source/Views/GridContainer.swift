//
//  GridContainer.swift
//  Dupe
//
//  Created by Joshua James on 31.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

class GridContainer: UIView {
    
    @IBOutlet weak var grid: Grid?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureSubviews()
    }
    
    class func getGridContainer() -> GridContainer? {
        let container = UINib(nibName: "GridContainer",
                         bundle: nil).instantiate(withOwner: nil,
                                                  options: nil)[0] as? GridContainer
        return container
    }

    // MARK: - Configuration -
    
    private func configureSubviews() {
        
    }
    
}
