import UIKit

extension GameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView == ", collectionView == smallGrid ? "smallGrid" : "bigGrid")
        guard let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.CellIdentifier,
                                                                for: indexPath) as? GridCell,
            let gridCollectionView = collectionView as? GridCollectionView else {
            return UICollectionViewCell()
        }
        
        let isSelected = gridCollectionView.selectedIndexPaths.contains(indexPath)
                   
        gridCell.update(asSelected: isSelected)
                
        return gridCell
    }
    
}
