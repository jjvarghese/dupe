//
//  GameViewController+StateHandling.swift
//  Dupe
//
//  Created by Joshua James on 10.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
import UIKit

extension GameViewController {
    
    @objc func appWillEnterForegroundNotificationReceived(_ notification: Notification) {
        logoLabel.bob()
    }
    
}
