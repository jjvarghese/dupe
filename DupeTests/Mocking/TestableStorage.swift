//
//  TestableStorage.swift
//  DupeTests
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation
@testable import Dupe

class TestableStorage: UserDefaultsProtocol {
    
    private var mockedStorageDict: [String : Any?] = [:]
    
    func set(object: Any?,
             forKey key: String) {
        mockedStorageDict[key] = object
    }
    
    func getObject(forKey key: String) -> Any? {
        return mockedStorageDict[key] as Any?
    }
    
}
