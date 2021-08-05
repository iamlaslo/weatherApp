//
//  setValuesToLabels.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import Foundation

extension SettingsViewController {
    func setValuesToLabels() {
        unitsLabel.text = SettingsManager.shared.requestUnits.rawValue
        languageLabel.text = SettingsManager.shared.requestLanguage.rawValue
    }
}
