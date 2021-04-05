//
//  BundleProtocol.swift
//  Dupe
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

protocol BundleProtocol {
    
    // Return a wav or mp3 resource, whichever is found.
    func url(forResource resource: String) -> URL?
    
}
