import UIKit

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.CellIdentifier,
                                                                for: indexPath) as? GridCell,
            let gridCollectionView = collectionView as? GridCollectionView else {
            return UICollectionViewCell()
        }
        
        let isSelected = gridCollectionView.selectedIndices.contains(indexPath.item)
                   
        gridCell.update(asSelected: isSelected)
                
        return gridCell
    }
    
}
