//
//  GameViewController+MenuDelegate.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController: MenuDelegate {
    
    func menu(_ menu: Menu,
              selectedOption menuOption: MenuOption) {
        switch menuOption {
        case .start:
            handleStartPressed(menu: menu)
        case .about:
            handleAboutPressed()
        }
    }
    
    // MARK: - Private: Handling -
    
    private func handleStartPressed(menu: Menu) {
        bigGrid?.reset()
        soundProvider.playRandomTune()
        soundProvider.play(sfx: .start)
        scoreLabel?.isHidden = true
        currentScore = 0
        
        weak var weakSelf = self
        
        menu.fadeOut(for: 0.4,
                     completion: {
                        guard let strongSelf = weakSelf else { return }
                        
                        UILabel.spawnFloatingFadingLabels(toSuperview: strongSelf.view,
                                                          withTexts: ["Ready...", "Set...", "DUPE!"]) {
                            weakSelf?.spawnGrid(in: .center)
                        }
                     })
    }
    
    private func handleAboutPressed() {
        let nib = UINib(nibName: AboutView.NibName,
                        bundle: nil)
        guard let aboutView = nib.instantiate(withOwner: self, options: nil).first as? AboutView else { return }
        
        aboutView.delegate = self
        
        bigGrid?.alpha = 0
        
        weak var weakSelf = self
        
        menu?.fadeOut(for: 0.4, completion: {
            guard let strongSelf = weakSelf else { return }
            
            strongSelf.view.addSubviewWithConstraints(subview: aboutView,
                                                     atPosition: .center,
                                                     withWidth: strongSelf.view.frame.size.width,
                                                     withHeight: 200)
        })
    }
    
    
}