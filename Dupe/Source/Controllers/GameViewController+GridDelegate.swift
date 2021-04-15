import Foundation

extension GameViewController: GridDelegate {
    
    func gridDidCollide(_ grid: Grid) {
        session?.grids.removeAllGrids()
        
        triggerGameOver()
    }
    
    func grid(_ grid: Grid,
              didPanAt indexPath: IndexPath) {
        guard grid == bigGrid,
              let session = session else { return }
        
        grid.touch(indexPath: indexPath)
        
        session.checkForMatch()
    }
    
    func grid(_ grid: Grid,
              didEndPanningAt indexPath: IndexPath) {}
    
    func grid(_ grid: Grid,
              didSelect indexPath: IndexPath) {
        guard grid == bigGrid,
              let session = session else { return }
        
        grid.touch(indexPath: indexPath)
        
        session.checkForMatch()
    }
    
    // MARK: - Helper -
    
    
    
}
