import Foundation

extension GameViewController: GridDelegate {
    
    func gridDidCollide(_ grid: Grid) {
        grids.removeAllGrids()
        
        triggerGameOver()
    }
    
    func grid(_ grid: Grid,
              didPanAt indexPath: IndexPath) {
        guard grid == bigGrid, gameInProgress else { return }
        
        grid.touch(indexPath: indexPath)
        
        checkForMatch()
    }
    
    func grid(_ grid: Grid,
              didEndPanningAt indexPath: IndexPath) {}
    
    func grid(_ grid: Grid,
              didSelect indexPath: IndexPath) {
        guard grid == bigGrid, gameInProgress else { return }
        
        grid.touch(indexPath: indexPath)
        
        checkForMatch()
    }
    
    // MARK: - Helper -
    
    private func checkForMatch() {
        guard let bigGridIndices = bigGrid?.selectedIndices.sorted() else { return }
                     
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            for grid in self.grids {
                let gridIndices = grid.selectedIndices.sorted()
                
                if bigGridIndices.elementsEqual(gridIndices) {
                    self.triggerMatch(matchedGrid: grid)
                }
            }
        }
    }
    
}
