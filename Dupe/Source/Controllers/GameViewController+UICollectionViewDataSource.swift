import UIKit

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.GridCell,
                                                                for: indexPath) as? GridCell,
            let gridCollectionView = collectionView as? Grid else {
            return UICollectionViewCell()
        }
        
        let isSelected = gridCollectionView.selectedIndices.contains(indexPath.item)
                   
        gridCell.index = indexPath.row
        gridCell.update(asSelected: isSelected,
                        withRubikColor: gridCollectionView.rubikColor)
        
        if isSelected {
            soundProvider.play(sfx: .touch)
        }
        
        if collectionView == bigGrid {
            let identifier = String(format: "%d", indexPath.row)
            
            gridCell.accessibilityIdentifier = identifier
        }
                
        return gridCell
    }
    
}
