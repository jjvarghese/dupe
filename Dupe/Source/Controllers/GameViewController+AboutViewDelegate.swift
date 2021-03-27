//
//  GameViewController+AboutViewDelegate.swift
//  Dupe
//
//  Created by Joshua James on 27.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension GameViewController: AboutViewDelegate {
    
    func aboutViewIsGoingBack(_ aboutView: AboutView) {
        aboutView.removeFromSuperview()
        
        bigGrid?.alpha = 1
        menu?.alpha = 1
    }
    
}
