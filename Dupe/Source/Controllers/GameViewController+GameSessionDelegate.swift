//
//  GameViewController+GameSessionDelegate.swift
//  Dupe
//
//  Created by Joshua James on 15.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController: GameSessionDelegate {
    
    func gameSessionRequestsCollisionGrid(_ gameSession: GameSession) -> Grid? {
        return bigGrid 
    }
    
    func gameSessionRequestsInitialTempo(_ gameSession: GameSession,
                                         initialTempo: @escaping (TimeInterval) -> Void) {
        determineInitialTempo { (tempo) in
            initialTempo(tempo)
        }
    }
    
    func gameSessionTriggersMatch(_ gameSession: GameSession) {
        self.soundProvider.play(sfx: .matched)
    }
    
    func gameSessionTriggersGameOver(_ gameSession: GameSession) {
        
    }
    
    // MARK: - Private -
    
    private func determineInitialTempo(withCompletion completion: @escaping (TimeInterval) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let window = UIApplication.shared.windows.first
            let top = (window?.safeAreaInsets.top ?? 0) + Grid.START_POSITION
            let collisionPoint = self.bigGrid?.frame.origin.y ?? 0
            let bottom = top + (self.view.frame.size.width / 5)
            let distanceToFall = collisionPoint - bottom
            let timeToFall: CGFloat = Constants.Values.initialTimeToFall
            let pixelsPerSecond = distanceToFall / timeToFall
            let finalTempo = TimeInterval(1 / pixelsPerSecond)
            
            completion(finalTempo)
        }
    }
    
}
