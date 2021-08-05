//
//  SettingsViewController.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 4.8.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerMenuView: PickerMenuView!
    
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    var pickerVariants: [String]?
    var pickerRow: Int?
    var currentPicker: String?
    var startAtRow: Int?
    
    var isMenuOpened: Bool?
    
    var selectedUnits: RequestUnitType?
    var oldUnits: RequestUnitType?
    
    var selectedLanguage: RequestLangType?
    var oldLanguage: RequestLangType?
    
    let unitsPickerVariants: [String] = ["Standart", "Metric", "Imperial"]
    let langPickerVariants: [String] = ["English", "Українська", "Русский"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerRow = 0
        setValuesToLabels()
        isMenuOpened = false
        pickerMenuView.isHidden = false
        pickerMenuView.alpha = 0
        
        oldUnits = SettingsManager.shared.requestUnits
        oldLanguage = SettingsManager.shared.requestLanguage
    }
    
    
    @IBAction func menuDoneClicked(_ sender: UIButton) {
        let units = SettingsManager.shared.requestUnits
        let lang = SettingsManager.shared.requestLanguage
        
        if units != oldUnits, oldUnits != nil, lang == oldLanguage {
            restartAlert(withLang: lang, isLang: nil, isUnits: units)
        } else if lang != oldLanguage, oldLanguage != nil, units == oldUnits {
            restartAlert(withLang: lang, isLang: lang, isUnits: nil)
        } else if units != oldUnits, oldUnits != nil,  lang != oldLanguage, oldLanguage != nil {
            restartAlert(withLang: lang, isLang: lang, isUnits: units)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func menuCancelClicked(_ sender: UIButton) {
        var units = SettingsManager.shared.requestUnits
        var lang = SettingsManager.shared.requestLanguage
        
        if oldUnits != nil, oldLanguage != nil {
            units = oldUnits!
            lang = oldLanguage!
        } else if oldUnits != nil {
            units = oldUnits!
        } else if oldLanguage != nil {
            lang = oldLanguage!
        }
        
        SettingsManager.shared.requestUnits = units
        SettingsManager.shared.requestLanguage = lang
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unitsClicked(_ sender: UIButton) {
        currentPicker = "units"
        pickerView.reloadAllComponents()
        pickerVariants = unitsPickerVariants
        
        if isMenuOpened! == false {
            pickerMenuView.animShow()
        }
        isMenuOpened = true
        
        let previousUnits = SettingsManager.shared.requestUnits.rawValue
        
        switch previousUnits {
        case "standart":
            startAtRow = 0
        case "metric":
            startAtRow = 1
        case "imperial":
            startAtRow = 2
        default:
            startAtRow = 0
        }
    }
    
    @IBAction func langClicked(_ sender: UIButton) {
        print("clicked")
        currentPicker = "lang"
        pickerView.reloadAllComponents()
        pickerVariants = langPickerVariants
        if isMenuOpened! == false {
            pickerMenuView.animShow()
        }
        
        isMenuOpened = true
    }
    
    @IBAction func pickerSkipClicked(_ sender: UIButton) {
        pickerMenuView.animHide()
        isMenuOpened = false
    }
    
    @IBAction func pickerDoneClicked(_ sender: UIButton) {
        if currentPicker == "units" {
            switch pickerRow {
            case 0:
                selectedUnits = RequestUnitType.unitStandart
            case 1:
                selectedUnits = RequestUnitType.unitMetric
            case 2:
                selectedUnits = RequestUnitType.unitImperial
            default:
                selectedUnits = SettingsManager.shared.requestUnits
            }
            
            if SettingsManager.shared.requestUnits != selectedUnits, selectedUnits != nil {
                SettingsManager.shared.requestUnits = selectedUnits!
            }
            
        } else if currentPicker == "lang" {
            switch pickerRow {
            case 0:
                selectedLanguage = RequestLangType.langEn
                UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
            case 1:
                selectedLanguage = RequestLangType.langUa
                UserDefaults.standard.set(["uk-UA"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
            case 2:
                selectedLanguage = RequestLangType.langRu
                UserDefaults.standard.set(["ru"], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
            default:
                selectedLanguage = SettingsManager.shared.requestLanguage
            }
            
            
            
            if SettingsManager.shared.requestLanguage != selectedLanguage, selectedLanguage != nil {
                SettingsManager.shared.requestLanguage = selectedLanguage!
            }
            
        } else {
            print("no picker selected")
        }
        
        setValuesToLabels()
        
        pickerMenuView.animHide()
        isMenuOpened = false
    }
}
