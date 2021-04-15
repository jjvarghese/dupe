import Foundation

extension GameViewController: GridDelegate {
    
    func gridDidCollide(_ grid: Grid) {
        session?.grids.removeAllGrids()
        
        triggerGameOver()
    }
    
    func grid(_ grid: Grid,
              didPanAt indexPath: IndexPath) {
        guard grid == bigGrid, session != nil else { return }
        
        grid.touch(indexPath: indexPath)
        
        checkForMatch()
    }
    
    func grid(_ grid: Grid,
              didEndPanningAt indexPath: IndexPath) {}
    
    func grid(_ grid: Grid,
              didSelect indexPath: IndexPath) {
        guard grid == bigGrid, session != nil else { return }
        
        grid.touch(indexPath: indexPath)
        
        checkForMatch()
    }
    
    // MARK: - Helper -
    
    private func checkForMatch() {
        guard let bigGridIndices = bigGrid?.selectedIndices.sorted() else { return }
                     
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let session = self.session else { return }
            
            for grid in session.grids {
                let gridIndices = grid.selectedIndices.sorted()
                
                if bigGridIndices.elementsEqual(gridIndices) {
                    self.triggerMatch(matchedGrid: grid)
                }
            }
        }
    }
    
}
