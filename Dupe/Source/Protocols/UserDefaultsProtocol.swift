//
//  UserDefaultProtocol.swift
//  Dupe
//
//  Created by Joshua James on 05.04.21.
//  Copyright © 2021 Cosmic. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    
    func set(object: Any?,
             forKey key: String)
    
    func getObject(forKey key: String) -> Any?
    
}
