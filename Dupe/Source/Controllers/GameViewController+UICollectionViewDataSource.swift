import UIKit

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView is ColorPicker {
            return 1
        } else if collectionView is Grid {
            return 16
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let grid = collectionView as? Grid {
            return getGridCellForGrid(grid: grid,
                                      indexPath: indexPath) ?? UICollectionViewCell()
        } else if let colorPicker = collectionView as? ColorPicker {
            return getGridCellForColorPicker(colorPicker: colorPicker,
                                             indexPath: indexPath) ?? UICollectionViewCell()
        } else {
            return UICollectionViewCell()
        }
    }
    
    // MARK: - Private -
    
    private func getGridCellForColorPicker(colorPicker: ColorPicker,
                                           indexPath: IndexPath) -> GridCell? {
        let gridCell = colorPicker.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.GridCell,
                                                          for: indexPath) as? GridCell
        
        gridCell?.update(asSelected: false,
                         withRubikColor: colorPicker.rubikColor ?? RubikColor.getRandomRubikColor(),
                         withAllClearCorners: true)
        
        return gridCell
    }
    
    private func getGridCellForGrid(grid: Grid,
                                    indexPath: IndexPath) -> GridCell? {
        let gridCell = grid.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.GridCell,
                                                          for: indexPath) as? GridCell
        
        let isSelected = grid.selectedIndices.contains(indexPath.item)
                   
        gridCell?.index = indexPath.row
        gridCell?.update(asSelected: isSelected,
                        withRubikColor: grid.rubikColor)
        
        if isSelected {
            soundProvider.play(sfx: .touch)
        }
        
        if grid == bigGrid {
            let identifier = String(format: "%d", indexPath.row)
            
            gridCell?.accessibilityIdentifier = identifier
        }
                
        return gridCell
    }
    
}
