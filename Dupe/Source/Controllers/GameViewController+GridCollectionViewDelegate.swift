import Foundation

extension GameViewController: GridCollectionViewDelegate {
    
    func gridCollectionViewDidFinishMatchAnimation(collectionView: GridCollectionView) {
        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            guard let currentTempo = weakSelf?.currentTempo else { return }
            
            var tempo = currentTempo
            
            if currentTempo > 0.02 { // Maximum speed - any faster, and it's too hard
                tempo -= 0.01
            }
            
            weakSelf?.beginDescentOfSmallGrid(withDuration: tempo)
            
            collectionView.isHidden = false
        }
    }
    
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
