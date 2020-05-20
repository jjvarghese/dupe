import UIKit

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard collectionView == bigGrid,
            let bigGrid = bigGrid else {
            return
        }
        
        if bigGrid.selectedIndexPaths.contains(indexPath) {
            bigGrid.selectedIndexPaths.removeAll(where: { (selectedIndexPath) -> Bool in
                return selectedIndexPath == indexPath
            })
        } else {
            bigGrid.selectedIndexPaths.append(indexPath)
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
    
}
