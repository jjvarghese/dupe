//
//  GameViewController+MenuDelegate.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit
import FFPopup

extension GameViewController: MenuDelegate {
    
    func menu(_ menu: Menu,
              selectedOption menuOption: MenuOption) {
        weak var weakSelf = self
        
        DispatchQueue.main.async {
            switch menuOption {
            case .start:
                weakSelf?.handleStartPressed(menu: menu)
            case .about:
                weakSelf?.handleAboutPressed()
            }
        }
    }
    
    // MARK: - Private: Handling -
    
    private func handleStartPressed(menu: Menu) {
        weak var weakSelf = self

        DispatchQueue.main.async {
            weakSelf?.gameInProgress = true
            weakSelf?.bigGrid?.reset()
            weakSelf?.soundProvider.playRandomTune()
            weakSelf?.soundProvider.play(sfx: .start)
            weakSelf?.scoreLabel?.isHidden = true
            weakSelf?.currentScore = 0
            
            menu.fadeOut(for: 0.4,
                         completion: {
                            guard let strongSelf = weakSelf else { return }
                            
                            UILabel.spawnFloatingFadingLabels(toSuperview: strongSelf.view,
                                                              withTexts: ["Ready...", "Set...", "DUPE!"]) {
                                weakSelf?.spawnGrid(in: .center)
                            }
                         })
        }
    }
    
    private func handleAboutPressed() {
        let nib = UINib(nibName: AboutView.NibName,
                        bundle: nil)
        guard let aboutView = nib.instantiate(withOwner: self, options: nil).first as? AboutView else { return }
                
        let popup = FFPopup(contetnView: aboutView,
                            showType: .bounceInFromTop,
                            dismissType: .slideOutToTop,
                            maskType: .dimmed,
                            dismissOnBackgroundTouch: true,
                            dismissOnContentTouch: true)
        let layout = FFPopupLayout(horizontal: .center,
                                   vertical: .top)
        
        popup.show(layout: layout)
    }
    
    
}
