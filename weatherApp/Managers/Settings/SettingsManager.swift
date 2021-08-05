//
//  SettingsManager.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 4.8.2021.
//

import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    private init() { }
    private var storage = UserDefaults()
    
    enum StorageKey: String {
        case storageLangKey
        case storageUnitKey
    }
    
    var requestLanguage: RequestLangType {
        get {
            let defVal = RequestLangType.langEn
            if let lang = storage.string(forKey:  StorageKey.storageLangKey.rawValue) {
                return RequestLangType(rawValue: lang) ?? defVal
            }
            return defVal
        }
        set {
            storage.setValue(newValue.rawValue, forKey: StorageKey.storageLangKey.rawValue)
        }
    }
    
    var requestUnits: RequestUnitType {
        get {
            let defVal = RequestUnitType.unitMetric
            if let unit = storage.string(forKey:  StorageKey.storageUnitKey.rawValue) {
                return RequestUnitType(rawValue: unit) ?? defVal
            }
            return defVal
        }
        set {
            storage.setValue(newValue.rawValue, forKey: StorageKey.storageUnitKey.rawValue)
        }
    }
    
}
