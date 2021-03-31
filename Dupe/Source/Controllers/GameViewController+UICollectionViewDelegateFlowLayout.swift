import UIKit

extension GameViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bigGrid {
            let size: CGFloat = (collectionView.frame.size.width / 4)

            return CGSize(width: size,
                          height: size)
        } else {
            let size: CGFloat = (collectionView.frame.size.width / 4) - 3

            return CGSize(width: size,
                          height: size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == bigGrid {
            return UIEdgeInsets(top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0)
        } else {
            return UIEdgeInsets(top: 0,
                                left: 0,
                                bottom: 0,
                                right: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == bigGrid ? 0 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == bigGrid ? 0 : 2
    }
        
}

