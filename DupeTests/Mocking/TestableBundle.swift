//
//  TestableBundle.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
@testable import Dupe

class TestableBundle: BundleProtocol {
    
    private var mockedFiles = ["1.mp3", "2.wav", "3.mp3", "4.wav"]
    private static let mockedResourceBaseURL = "file:///sounds"
    
    func url(forResource resource: String) -> URL? {
        let retrievedFile = mockedFiles.first { (file) -> Bool in
            return file == resource
        }
        
        let mockedResourceURLString = String(format: "%@/%@",
                                             TestableBundle.mockedResourceBaseURL,
                                             retrievedFile ?? "")
        
        let mockedResourceURL = URL(string: mockedResourceURLString)
        
        return mockedResourceURL
    }
    
}
