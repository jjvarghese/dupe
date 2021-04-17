//
//  ColorPicker.swift
//  Dupe
//
//  Created by Joshua James on 17.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

protocol ColorPickerDelegate {
    
    func colorPickerWasPressed(_ colorPicker: ColorPicker)
    
}

class ColorPicker: UICollectionView {
    
    var colorPickerDelegate: ColorPickerDelegate?
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
        configureTouchGestures()
    }
    
    func configure(toColorPickable colorPickable: ColorPickable,
                   withRubikColor rubikColor: RubikColor) {
        delegate = colorPickable
        dataSource = colorPickable
        colorPickerDelegate = colorPickable
        self.rubikColor = rubikColor
    }
    
    private func configureRegistration() {
        let nib = UINib.init(nibName: Constants.NibNames.GridCell,
                             bundle: nil)
        
        register(nib,
                 forCellWithReuseIdentifier: Constants.CellIdentifiers.GridCell)
    }
    
    private func configureTouchGestures() {
        removeAllExistingGestureRecognizers()
        
        let touchGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self,
                                                                               action: #selector(didTap(touchGesture:)))
        touchGesture.delegate = self
        touchGesture.numberOfTapsRequired = 1
        touchGesture.numberOfTouchesRequired = 1
        touchGesture.cancelsTouchesInView = false
        
        addGestureRecognizer(touchGesture)
    }
    
}
