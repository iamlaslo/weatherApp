//
//  DailyViewController.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 4.8.2021.
//

import Foundation
import UIKit

class DailyViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var wholeTempLabel: UILabel!
    @IBOutlet weak var wholeConditionsLabel: UILabel!
    @IBOutlet weak var wholeImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    @IBOutlet weak var morningImageView: UIImageView!
    @IBOutlet weak var morningTempLabel: UILabel!
    @IBOutlet weak var morningFeelsLabel: UILabel!
    
    @IBOutlet weak var afternoonImageView: UIImageView!
    @IBOutlet weak var afternoonTempLabel: UILabel!
    @IBOutlet weak var afternoonFeelsLabel: UILabel!
    
    @IBOutlet weak var eveningImageView: UIImageView!
    @IBOutlet weak var eveningTempLabel: UILabel!
    @IBOutlet weak var eveningFeelsLabel: UILabel!
    
    @IBOutlet weak var nightImageView: UIImageView!
    @IBOutlet weak var nightTempLabel: UILabel!
    @IBOutlet weak var nightFeelsLabel: UILabel!
    
    
    var model: DailyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        
        if let model = model {
            let interval = TimeInterval(model.dt)
            let date = Date(timeIntervalSince1970: interval)
            dateLabel.text = dateFormatter.string(from: date)
            
            wholeTempLabel.text = String(Int(model.temp!.day)) + "°"
            wholeConditionsLabel.text = "| " + model.weather.last!.desc
            wholeImageView.image = UIImage(named: model.weather.last!.icon)
            
            minTempLabel.text = String(Int(model.temp!.min)) + "°"
            maxTempLabel.text = String(Int(model.temp!.max)) + "°"
            
            
            morningImageView.image = UIImage(named: model.weather.last!.icon)
            morningTempLabel.text = String(Int(model.temp!.morn))
            morningFeelsLabel.text = String(Int(model.feelsLike!.morn))
            
            afternoonImageView.image = UIImage(named: model.weather.last!.icon)
            afternoonTempLabel.text = String(Int(model.temp!.day))
            afternoonFeelsLabel.text = String(Int(model.feelsLike!.day))
            
            eveningImageView.image = UIImage(named: model.weather.last!.icon)
            eveningTempLabel.text = String(Int(model.temp!.eve))
            eveningFeelsLabel.text = String(Int(model.feelsLike!.eve))
            
            nightImageView.image = UIImage(named: model.weather.last!.icon)
            nightTempLabel.text = String(Int(model.temp!.night))
            nightFeelsLabel.text = String(Int(model.feelsLike!.night))
        }
        
        
    }
    
}
