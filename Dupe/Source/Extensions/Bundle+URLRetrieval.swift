//
//  Bundle+URLRetrieval.swift
//  Dupe
//
//  Created by Joshua James on 20.03.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension Bundle {
    
    // Return a wav or mp3 resource, whichever is found.
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
