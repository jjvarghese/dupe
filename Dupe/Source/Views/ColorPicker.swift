//
//  ColorPicker.swift
//  Dupe
//
//  Created by Joshua James on 17.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

class ColorPicker: UICollectionView {
    
    var rubikColor: RubikColor?
    
    // MARK: - Init  -
    
    required init(withRubikColor rubikColor: RubikColor) {
        self.rubikColor = rubikColor
                
        super.init(frame: .zero,
                   collectionViewLayout: UICollectionViewFlowLayout())
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    // MARK: - Configuration -
    
    private func configure() {
        configureRegistration()
    }
    
    func configure(toGriddable griddable: Griddable,
                   withRubikColor rubikColor: RubikColor) {
        delegate = griddable
        dataSource = griddable
        self.rubikColor = rubikColor
    }
    
    private func configureRegistration() {
        let nib = UINib.init(nibName: Constants.NibNames.GridCell,
                             bundle: nil)
        
        register(nib,
                 forCellWithReuseIdentifier: Constants.CellIdentifiers.GridCell)
    }
    
}
