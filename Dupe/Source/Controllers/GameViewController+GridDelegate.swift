import Foundation

extension GameViewController: GridDelegate {
    
    func gridDidCollide(_ grid: Grid) {
        triggerGameOver()
    }
    
    func gridRequestsInsanityMode(_ grid: Grid) -> Bool {
        return isInsaneMode
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
        guard let bigGridIndices = bigGrid?.selectedIndices.sorted() else { return }
                
        for grid in grids {
            let gridIndices = grid.selectedIndices.sorted()
            
            if bigGridIndices.elementsEqual(gridIndices) {                
                weak var weakSelf = self
                
                DispatchQueue.main.async {
                    weakSelf?.triggerMatch(matchedGrid: grid)
                }
            }
        }
    }
    
}
