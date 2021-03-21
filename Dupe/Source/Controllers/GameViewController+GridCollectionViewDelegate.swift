import Foundation

extension GameViewController: GridCollectionViewDelegate {
    
    func gridCollectionViewDidCollide(collectionView: GridCollectionView) {
        if isInsaneMode || collectionView != smallGrid {
            isInsaneMode = false
        } else {
            triggerGameOver()
        }
    }
    
    func gridCollectionViewRequestsCurrentTempo(collectionView: GridCollectionView) -> TimeInterval {
        return currentTempo
    }
    
    func gridCollectionViewRequestsInsanityMode(collectionView: GridCollectionView) -> Bool {
        return isInsaneMode
    }
    
    func gridCollectionViewDidFinishMatchAnimation(collectionView: GridCollectionView) {
        
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
              let leftGridIndices = leftGrid?.selectedIndices.sorted(),
              let rightGridIndices = rightGrid?.selectedIndices.sorted(),
            let bigGridIndices = bigGrid?.selectedIndices.sorted() else { return }

        if bigGridIndices.elementsEqual(smallGridIndices) {
            triggerMatch(forGrid: smallGrid)
        } else if bigGridIndices.elementsEqual(leftGridIndices) {
            triggerMatch(forGrid: leftGrid)
        } else if bigGridIndices.elementsEqual(rightGridIndices) {
            triggerMatch(forGrid: rightGrid)
        }
    }
    
}
