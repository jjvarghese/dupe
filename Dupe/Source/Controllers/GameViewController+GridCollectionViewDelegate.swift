import Foundation

extension GameViewController: GridCollectionViewDelegate {
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didPanAt indexPath: IndexPath) {        
        collectionView.touch(indexPath: indexPath)
        
        checkForMatch()
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didEndPanningAt indexPath: IndexPath) {
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didSelect indexPath: IndexPath) {
        collectionView.touch(indexPath: indexPath)
        
        checkForMatch()
    }
    
    // MARK: - Helper -
    
    private func checkForMatch() {
        guard let smallGridIndices = smallGrid?.selectedIndices.sorted(),
            let bigGridIndices = bigGrid?.selectedIndices.sorted() else { return }

        if bigGridIndices.elementsEqual(smallGridIndices) {
            triggerMatch()
        }
    }
    
}
