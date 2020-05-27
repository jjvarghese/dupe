import Foundation

extension GameViewController: GridCollectionViewDelegate {
    
    func gridCollectionViewDidFinishMatchAnimation(collectionView: GridCollectionView) {
        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            weakSelf?.releaseNewSmallGrid()
        }
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didPanAt indexPath: IndexPath) {
        guard collectionView == bigGrid else { return }
        
        collectionView.touch(indexPath: indexPath)
        
        checkForMatch()
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didEndPanningAt indexPath: IndexPath) {
    }
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didSelect indexPath: IndexPath) {
        guard collectionView == bigGrid else { return }
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
