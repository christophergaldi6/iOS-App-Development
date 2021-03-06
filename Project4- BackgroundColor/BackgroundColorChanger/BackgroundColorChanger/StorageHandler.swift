//  Christopher Galdi
//  StorageHandler.swift
//  BackgroundColorChanger
//
//  Created by Christopher Galdi on 11/21/20.
//

import Foundation

struct StorageHandler {
    static var defaultStorage: UserDefaults = UserDefaults.standard
    static let defaultKey = "ColorCollection"
    
    static func getStorage() {
        if isSet(key: self.defaultKey) {
            let encodedString = UserDefaults.standard.dictionaryRepresentation()[self.defaultKey] as! String
            
            ColorManager.colorCollection = decodeCollection(encodedString.data(using: .utf8)!)
        }
    }
    
    static func isSet(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    static func set(value: Color) {
        ColorManager.colorCollection.append(value)
        
        defaultStorage.setValue(encodeCollection(), forKey: self.defaultKey)
    }
    static func set() {
        defaultStorage.setValue(encodeCollection(), forKey: self.defaultKey)
    }

    static func encodeCollection() -> String {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(ColorManager.colorCollection)
        else {
            return ""
        }
        print(storageCount())
        
        guard let stringEncoded = String(data: encoded, encoding: .utf8)
        else{
            return ""
        }
        return stringEncoded
    }
    
    static func decodeCollection(_ encodedString: Data) -> [Color] {
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode([Color].self, from: encodedString)
        else {
            let newColorColllection: [Color] = []
            return newColorColllection
        }
        
        return decoded
    }
    
    static func storageCount() -> Int {
        return ColorManager.colorCollection.count
    }
}

