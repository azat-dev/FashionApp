//
//  LocalKeyValueStorage.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 28.05.22.
//

import Foundation

// MARK: - Interfaces

protocol LocalKeyValueStorage {
    
    func setItem<T>(key: String, value: T) where T: Encodable
    func getItem<T>(key: String, as: T.Type) -> T? where T: Decodable
    func removeItem(key: String)
    func clean()
}

// MARK: - Implementations

class DefaultLocalKeyValueStorage: LocalKeyValueStorage {
    
    func setItem<T>(key: String, value: T) where T: Encodable {
        
        let encoder = JSONEncoder()
        let encodedValue = try! encoder.encode(value)
        
        UserDefaults.standard.set(encodedValue, forKey: key)
    }
    
    func getItem<T>(key: String, as: T.Type) -> T? where T: Decodable {
        
        let encodedValue = UserDefaults.standard.value(forKey: key) as? Data
        
        guard let encodedValue = encodedValue else {
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: encodedValue)
    }
    
    func removeItem(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func clean() {
        
        let defaults = UserDefaults.standard
        
        defaults.dictionaryRepresentation().keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
