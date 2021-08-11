import Foundation

extension GameViewController: GridDelegate {
    
    func grid(_ grid: Grid, wasUpdatedAt indexPath: IndexPath) {
        playTouchedSound(forIndexPath: indexPath)
    }
    
    func gridDidFinishDescending(_ grid: Grid) {
//        grid.animate(withAnimation: .wobble)
    }
    
    func grid(_ grid: Grid,
              didPanAt indexPath: IndexPath) {
        handleSelection(forIndexPath: indexPath)
    }
    
    func grid(_ grid: Grid,
              didEndPanningAt indexPath: IndexPath) {}
    
    func grid(_ grid: Grid,
              didSelect indexPath: IndexPath) {
        if grid == bigGrid {
            handleSelection(forIndexPath: indexPath)
        } else {
            grid.animate(withAnimation: .Squeeze)
            
            flipColor(to: grid.rubikColor)
        }
    }
    
    // MARK: - Private -
    
    private func handleSelection(forIndexPath indexPath: IndexPath) {
        guard let session = session else { return }

        bigGrid.touch(indexPath: indexPath)
        
        session.checkForMatch()
    }
    
    private func playTouchedSound(forIndexPath indexPath: IndexPath) {
        DispatchQueue.global().async { [weak self] in
            guard let bigGrid = self?.bigGrid else { return }
            
            if bigGrid.selectedIndices.contains(indexPath.row) {
                self?.soundProvider.play(sfx: .touch)
            }
        }
    }
    
    private func flipColor(to rubikColor: RubikColor) {
        guard bigGrid.rubikColor != rubikColor else { return }
        
        session?.scoreMultiplier = 0
        
        bigGrid.rubikColor = rubikColor
        
        let coinFlip = Int.random(in: 0...1)
        
        bigGrid.reset(withAnimation: coinFlip == 0 ? .FlipX : .FlipY)
        
        soundProvider.play(sfx: .touch)
    }
    
}
