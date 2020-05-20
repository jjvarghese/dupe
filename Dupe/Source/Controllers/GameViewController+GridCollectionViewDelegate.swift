import Foundation

extension GameViewController: GridCollectionViewDelegate {
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didPanAt indexPath: IndexPath) {
        NSLog("didPanAt", "")
        
        collectionView.touch(indexPath: indexPath)
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didEndPanningAt indexPath: IndexPath) {
        NSLog("didEndPanning", "")
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didSelect indexPath: IndexPath) {
        NSLog("didSelect", "")
        
        collectionView.touch(indexPath: indexPath)
    }
    
}
