//
//  Bundle+BundleProtocol.swift
//  Dupe
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension Bundle: BundleProtocol {
    
    func url(forResource resource: String) -> URL? {
        if let mp3Url = url(forResource: resource,
                                        withExtension: "mp3") {
            return mp3Url
        } else if let wavUrl = url(forResource: resource,
                                                withExtension: "wav") {
            return wavUrl
        } else {
            return nil
        }
    }
    
}
