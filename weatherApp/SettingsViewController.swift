//
//  SettingsViewController.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 4.8.2021.
//

import UIKit

enum LanguageSettingsVariants: Int, CaseIterable {
    case eng = 0
    case ru
    case ua
}

class PickerMenuView: UIView {
    
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerMenuView: PickerMenuView!
    
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    var pickerVariants: [String]?
    var pickerRow: Int?
    var currentPicker: String?
    var startAtRow: Int?
    
    // add lang loc
    let unitsPickerVariants: [String] = ["Standart", "Metric", "Imperial"]
    let langPickerVariants: [String] = ["English", "Українська", "Русский"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerRow = 0
        setValuesToLabels()
    }
    
    func setValuesToLabels() {
        unitsLabel.text = SettingsManager.shared.requestUnits.rawValue
        languageLabel.text = SettingsManager.shared.requestLanguage.rawValue
    }
    
    @IBAction func unitsClicked(_ sender: UIButton) {
        currentPicker = "units"
        pickerView.reloadAllComponents()
        pickerVariants = unitsPickerVariants
        pickerMenuView.isHidden = false
//        pickerMenuView.show()
        
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
    
//    func unitsRestartAlert(withLang: ) {
//        if toLanguage == .langEn {
//            alert.title = "Please, restart the app"
//            alert.message = "We need to restart app to change the language"
//        } else if toLanguage == .langRu {
//            alert.title = "Пожалуйста, перезапустите приложение"
//            alert.message = "Для изменения языка необходимо перезапустить приложение"
//        } else if toLanguage == .langUa {
//            alert.title = "Будь ласка, перезапустіть додаток"
//            alert.message = "Для зміни мови потрібно перезапустити додаток"
//        }
//    }
    
    func restartAlert(toLanguage: RequestLangType) {
        let alert = UIAlertController()
        
        if toLanguage == .langEn {
            alert.title = "Please, restart the app"
            alert.message = "We need to restart app to change the language"
        } else if toLanguage == .langRu {
            alert.title = "Пожалуйста, перезапустите приложение"
            alert.message = "Для изменения языка необходимо перезапустить приложение"
        } else if toLanguage == .langUa {
            alert.title = "Будь ласка, перезапустіть додаток"
            alert.message = "Для зміни мови потрібно перезапустити додаток"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            exit(0)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func langClicked(_ sender: UIButton) {
        currentPicker = "lang"
        pickerView.reloadAllComponents()
        pickerVariants = langPickerVariants
        pickerMenuView.isHidden = false
    }
    
    @IBAction func pickerSkipClicked(_ sender: UIButton) {
//        pickerMenuView.isHidden = true
//        PickerMenuView.hide(pickerMenuView)
//        pickerMenuView.hide()
        pickerMenuView.fadeOut()
    }
    
    @IBAction func pickerDoneClicked(_ sender: UIButton) {
        
        if currentPicker == "units" {
            var selectedUnits: RequestUnitType
            print(SettingsManager.shared.requestUnits.rawValue)
            
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
            
            SettingsManager.shared.requestUnits = selectedUnits
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let MainViewController = storyboard.instantiateViewController(identifier: "MainVC") as? ViewController else { return }
            
            
            MainViewController.reloadLocation()
            
        } else if currentPicker == "lang" {
            var selectedLanguage: RequestLangType
            
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
            
            if SettingsManager.shared.requestLanguage != selectedLanguage {
                SettingsManager.shared.requestLanguage = selectedLanguage
                restartAlert(toLanguage: selectedLanguage)
            }
            
        } else {
            print("no picker selected")
        }
        
        setValuesToLabels()
        pickerMenuView.isHidden = true
    }
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LanguageSettingsVariants.allCases.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let output = pickerVariants {
            return output[row]
        }
        return "error"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerRow = row
    }
}


extension UIView {

func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
    self.alpha = 0.0

    UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.isHidden = false
        self.alpha = 1.0
    }, completion: completion)
}

func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
    self.alpha = 1.0

    UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.alpha = 0.0
    }) { (completed) in
        self.isHidden = true
        completion(true)
    }
  }
}
