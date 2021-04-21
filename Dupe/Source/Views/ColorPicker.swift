//
//  ColorPicker.swift
//  Dupe
//
//  Created by Joshua James on 17.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit
import Spring

protocol ColorPickerDelegate {
    
    func colorPickerWasPressed(_ colorPicker: ColorPicker)
    
}

class ColorPicker: SpringView {
    
    var delegate: ColorPickerDelegate?
    var rubikColor: RubikColor?
    var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                            collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Init  -
    
    required init(withRubikColor rubikColor: RubikColor) {
        self.rubikColor = rubikColor
                
        super.init(frame: .zero)
        
        configure()
    }
    
    override init(frame: CGRect) {
        rubikColor = RubikColor.getRandomRubikColor()

        super.init(frame: frame)
        
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
        configureCollectionView()
    }
    
    func configure(withDelegate delegate: ColorPickerDelegate?,
                   withRubikColor rubikColor: RubikColor) {
        self.delegate = delegate
        self.rubikColor = rubikColor
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = bounds
        
        addSubview(collectionView)
    }
    
    private func configureRegistration() {
        let nib = UINib.init(nibName: Constants.NibNames.GridCell,
                             bundle: nil)
        
        collectionView.register(nib,
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
