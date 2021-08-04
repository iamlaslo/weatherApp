//
//  SettingsManager.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 4.8.2021.
//

import Foundation

enum RequestLangType: String, CaseIterable {
    case langEn = "en"
    case langUa = "ua"
    case langRu = "ru"
}

enum RequestUnitType: String {
    case unitStandart = "standart"
    case unitMetric = "metric"
    case unitImperial = "imperial"
}

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
            NetworkManager.shared
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
