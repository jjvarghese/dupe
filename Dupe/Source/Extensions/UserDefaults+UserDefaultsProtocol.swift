//
//  UserDefaults+UserDefaultsProtocol.swift
//  Dupe
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

extension UserDefaults: UserDefaultsProtocol {
    
    func getObject(forKey key: String) -> Any? {
        return object(forKey: key)
    }
    
    func set(object: Any?, forKey key: String) {
        setValue(object,
                 forKey: key)
    }
    
}
