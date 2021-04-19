import Foundation

extension GameViewController: GridDelegate {
    
    func gridDidFinishDescending(_ grid: Grid) {
//        session?.grids.restackIfNeeded()
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
    
}
