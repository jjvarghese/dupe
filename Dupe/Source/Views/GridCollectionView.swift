//
//  GridCollectionView.swift
//  Dupe
//
//  Created by Joshua James on 20.05.20.
//  Copyright © 2020 Cosmic. All rights reserved.
//

import UIKit

protocol GridCollectionViewDelegate {
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didPanAt indexPath: IndexPath)
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didEndPanningAt indexPath: IndexPath)
    
    func gridCollectionView(collectionView: GridCollectionView,
                            didSelect indexPath: IndexPath)
    
}

class GridCollectionView: UICollectionView {

    var gridDelegate: GridCollectionViewDelegate?
    var selectedIndexPaths: [IndexPath] = []
    
    private var swipeToggledIndexPaths: [IndexPath] = []
    
    // MARK: - UIView -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureGestures()
    }
    
    // MARK: - Updating -
    
    func touch(indexPath: IndexPath) {
        guard !swipeToggledIndexPaths.contains(indexPath) else { return }
        
        selectedIndexPaths.toggle(element: indexPath)

        reloadItems(at: [indexPath])
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
                
                swipeToggledIndexPaths.addIfNotAlreadyThere(element: indexPath)
            } else if panGesture.state == .changed {
                gridDelegate?.gridCollectionView(collectionView: self,
                                                 didPanAt: indexPath)
                
                swipeToggledIndexPaths.addIfNotAlreadyThere(element: indexPath)
            } else if panGesture.state == .ended {

                swipeToggledIndexPaths = []
                
                gridDelegate?.gridCollectionView(collectionView: self,
                                                 didEndPanningAt: indexPath)
            }
        }
    }
    
    // MARK: - Configuration -
    
    private func configureGestures() {
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
