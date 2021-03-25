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
            let gridCollectionView = collectionView as? Grid else {            return UICollectionViewCell()
        }
        
        let isSelected = gridCollectionView.selectedIndices.contains(indexPath.item)
                   
        gridCell.update(asSelected: isSelected)
        gridCell.shouldPulse = collectionView == bigGrid
        
        if isSelected {
            soundProvider.play(sfx: .touch)
        }
                
        return gridCell
    }
    
}
