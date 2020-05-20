import UIKit

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.CellIdentifier,
                                                                for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        if collectionView == bigGrid, let bigGrid = bigGrid {
            let isSelected = bigGrid.selectedIndexPaths.contains(indexPath)
            
            gridCell.update(asSelected: isSelected)
        }
                
        return gridCell
    }
    
}
