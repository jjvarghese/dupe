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
        if grid == bigGrid {
            guard let session = session else { return }
            
            grid.touch(indexPath: indexPath)
            
            session.checkForMatch()
        } else {
            flipColor(to: grid.rubikColor)
        }
       
    }
    
    // MARK: - Private -
    
    private func flipColor(to rubikColor: RubikColor) {
        guard bigGrid?.rubikColor != rubikColor else { return }
        
        bigGrid?.rubikColor = rubikColor
        
        let coinFlip = Int.random(in: 0...1)
        
        bigGrid?.reset(withAnimation: coinFlip == 0 ? .flipX : .flipY)
    }
    
}
