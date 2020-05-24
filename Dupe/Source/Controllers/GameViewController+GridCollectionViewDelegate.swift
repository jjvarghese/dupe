import Foundation

extension GameViewController: GridCollectionViewDelegate {
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didPanAt indexPath: IndexPath) {        
        collectionView.touch(indexPath: indexPath)
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didEndPanningAt indexPath: IndexPath) {
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didSelect indexPath: IndexPath) {
        collectionView.touch(indexPath: indexPath)
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didUpdateSelectedIndexes selectedIndexes: [IndexPath]) {
        checkForMatch(withSelectedIndexes: selectedIndexes)
    }
    
    // MARK: - Helper -
    
    private func checkForMatch(withSelectedIndexes selectedIndexes: [IndexPath]) {
        guard let smallGridIndexPaths = self.smallGrid?.selectedIndexPaths.sorted() else { return }

        if selectedIndexes.sorted().elementsEqual(smallGridIndexPaths) {
            triggerMatch()
            
        }
    }
    
}
