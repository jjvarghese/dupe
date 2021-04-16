import Foundation

extension GameViewController: GridDelegate {
    
    func gridDidCollide(_ grid: Grid) {
        soundProvider.play(sfx: .gameOver)
        soundProvider.stopAllTunes()
        
        logoLabel?.themeAsLogo()
        
        session?.triggerGameOver(withCompletion: { [weak self] in
            self?.session = nil
        })
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
