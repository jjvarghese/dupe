//
//  Grid+UICollectionViewDataSource.swift
//  Dupe
//
//  Created by Joshua James on 20.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension Grid: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return getGridCell(indexPath: indexPath) ?? UICollectionViewCell()
    }
    
    // MARK: - Private -
    
    private func getGridCell(indexPath: IndexPath) -> GridCell? {
        let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.GridCell,
                                                          for: indexPath) as? GridCell
        
        let isSelected = selectedIndices.contains(indexPath.item)
                   
        gridCell?.index = indexPath.row
        gridCell?.update(asSelected: isSelected,
                        withRubikColor: rubikColor)
        
//        if isSelected {
//            soundProvider.play(sfx: .touch)
//        }
        
        let identifier = String(format: "%d", indexPath.row)
            
        gridCell?.accessibilityIdentifier = identifier
                
        return gridCell
    }
    
}
