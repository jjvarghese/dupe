import UIKit

extension GameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == smallGrid {
            return CGSize.init(width: (collectionView.frame.size.width / 4) - 4,
                               height: (collectionView.frame.size.height / 4) - 4)
        } else {
            return CGSize.init(width: (collectionView.frame.size.width / 4) - 1,
                               height: (collectionView.frame.size.height / 4) - 1)
        }
    }
    
}
