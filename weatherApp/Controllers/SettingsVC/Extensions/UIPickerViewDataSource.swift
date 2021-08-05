//
//  UIPickerViewDataSource.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LanguageSettingsVariants.allCases.count
    }
}
