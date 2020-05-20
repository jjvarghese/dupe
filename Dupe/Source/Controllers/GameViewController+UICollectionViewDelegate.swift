import UIKit

extension GameViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard collectionView == bigGrid else {
            return
        }
        
        bigGrid?.touch(indexPath: indexPath)
    }
    
}
