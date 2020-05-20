import UIKit

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard collectionView == bigGrid,
            let bigGrid = bigGrid else {
            return
        }
        
        bigGrid.selectedIndexPaths.toggle(element: indexPath)
        
        collectionView.reloadItems(at: [indexPath])
    }
    
}
