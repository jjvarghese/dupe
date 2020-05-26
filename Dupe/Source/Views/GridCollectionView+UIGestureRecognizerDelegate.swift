import UIKit

extension GridCollectionView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
        
    // MARK: - Gesture Handling -
    
    @objc private func didTap(touchGesture: UITapGestureRecognizer) {
        let location = touchGesture.location(in: self)
        
        if let indexPath = indexPathForItem(at: location) {
            gridDelegate?.gridCollectionView(collectionView: self,
                                             didSelect: indexPath)
        }
    }
    
    @objc private func didPan(panGesture: UIPanGestureRecognizer) {
        let location = panGesture.location(in: self)
        
        if let indexPath = indexPathForItem(at: location) {
            if panGesture.state == .began {
                gridDelegate?.gridCollectionView(collectionView: self,
                                                 didSelect: indexPath)
                
                swipedIndices.addIfNotAlreadyThere(element: indexPath.item)
            } else if panGesture.state == .changed {
                gridDelegate?.gridCollectionView(collectionView: self,
                                                 didPanAt: indexPath)
                
                swipedIndices.addIfNotAlreadyThere(element: indexPath.item)
            } else if panGesture.state == .ended {

                swipedIndices = []
                
                gridDelegate?.gridCollectionView(collectionView: self,
                                                 didEndPanningAt: indexPath)
            }
        }
    }
    
    // MARK: - Configuration -
    
    func configureGestures() {
        let swipeGesture: UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self,
                                                                               action: #selector(didPan(panGesture:)))
        swipeGesture.delegate = self
        swipeGesture.cancelsTouchesInView = false
        
        addGestureRecognizer(swipeGesture)
        
        let touchGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self,
                                                                               action: #selector(didTap(touchGesture:)))
        touchGesture.delegate = self
        touchGesture.numberOfTapsRequired = 1
        touchGesture.numberOfTouchesRequired = 1
        touchGesture.cancelsTouchesInView = false
        
        addGestureRecognizer(touchGesture)
    }
    
}
