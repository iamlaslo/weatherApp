//
//  restartAlert.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit

extension SettingsViewController {
    func restartAlert(withLang: RequestLangType, isLang: RequestLangType?, isUnits: RequestUnitType?) {
        let alert = UIAlertController()
        
        var title: String = ""
        
        if isLang != nil && isUnits != nil {
            if isLang == .langEn {
                title = "language and units"
            } else if isLang == .langRu {
                title = "языка и единиц измерения"
            } else if isLang == .langUa {
                title = "мови та одиниць виміру"
            }
        } else if isLang != nil && isUnits == nil {
            if isLang == .langEn {
                title = "language"
            } else if isLang == .langRu {
                title = "языка"
            } else if isLang == .langUa {
                title = "мови"
            }
        } else if isLang == nil && isUnits != nil {
            if isLang == .langEn {
                title = "units"
            } else if isLang == .langRu {
                title = "единиц измерения"
            } else if isLang == .langUa {
                title = "одиниць виміру"
            }
        }
        
        if withLang == .langEn {
            alert.title = "Please, restart the app"
            alert.message = "You need to restart the app to change the \(title)"
        } else if withLang == .langRu {
            alert.title = "Пожалуйста, перезапустите приложение"
            alert.message = "Для изменения \(title) необходимо перезапустить приложение"
        } else if withLang == .langUa {
            alert.title = "Будь ласка, перезапустіть додаток"
            alert.message = "Для зміни \(title) потрібно перезапустити додаток"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            exit(0)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
