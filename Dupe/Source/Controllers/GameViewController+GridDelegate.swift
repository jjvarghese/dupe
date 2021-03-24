import Foundation

extension GameViewController: GridDelegate {
    
    func gridDidCollide(_ grid: Grid) {
        triggerGameOver()
    }
    
    func gridRequestsInsanityMode(_ grid: Grid) -> Bool {
        return isInsaneMode
    }
    
    func gridDidFinishMatchAnimation(_ grid: Grid) {
        weak var weakSelf = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            weakSelf?.releaseNewSmallGrid()
        }
    }
    
    func grid(_ grid: Grid,
              didPanAt indexPath: IndexPath) {
        guard grid == bigGrid else { return }
        
        grid.touch(indexPath: indexPath)
        
        checkForMatch()
    }
    
    func grid(_ grid: Grid,
              didEndPanningAt indexPath: IndexPath) {
    }
    
    func grid(_ grid: Grid,
              didSelect indexPath: IndexPath) {
        guard grid == bigGrid else { return }
        
        grid.touch(indexPath: indexPath)
        
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
