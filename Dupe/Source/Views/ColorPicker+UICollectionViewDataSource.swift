//
//  ColorPicker+UICollectionViewDataSource.swift
//  Dupe
//
//  Created by Joshua James on 21.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension ColorPicker: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return getGridCell(indexPath: indexPath) ?? UICollectionViewCell()
    }
    
    // MARK: - Private -
 
    private func getGridCell(indexPath: IndexPath) -> GridCell? {
        let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.GridCell,
                                                          for: indexPath) as? GridCell
        
        gridCell?.update(asSelected: false,
                         withRubikColor: rubikColor ?? RubikColor.getRandomRubikColor(),
                         withAllClearCorners: true)
        
        return gridCell
    }
    
}
