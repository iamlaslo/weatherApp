//
//  GetWindUnits.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 5.8.2021.
//

import Foundation

func getWindUnits() -> String {
    let lang = SettingsManager.shared.requestLanguage
    let units = SettingsManager.shared.requestUnits
    
    var output: String = ""
    
    if lang == .langEn {
        if units == .unitMetric || units == .unitStandart {
            output = "m/s"
        } else if units == .unitImperial {
            output = "mph"
        }
    } else if lang == .langRu || lang == .langUa {
        if units == .unitMetric || units == .unitStandart {
            output = "м/с"
        } else if units == .unitImperial {
            output = "м/ч"
        }
    }
    
    return output
}
