import Foundation

extension GameViewController: GridDelegate {
    
    func gridDidCollide(_ grid: Grid) {
        triggerGameOver()
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
                
        NSLog("** BIG GRID INDICES: %@", bigGridIndices)
        
        weak var weakSelf = self

        DispatchQueue.main.async {
            guard let strongSelf = weakSelf else { return }
            
            for grid in strongSelf.grids {
                let gridIndices = grid.selectedIndices.sorted()
                
                if bigGridIndices.elementsEqual(gridIndices) {
                    strongSelf.triggerMatch(matchedGrid: grid)
                }
            }
        }
    }
    
}
