//
//  setUI.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit

func setUI(model: DailyModel?, self: DailyViewController) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM YYYY"
    
    if let model = model {
        let interval = TimeInterval(model.dt)
        let date = Date(timeIntervalSince1970: interval)
        self.dateLabel.text = dateFormatter.string(from: date)
        
        self.wholeTempLabel.text = String(Int(model.temp!.day)) + "°"
        self.wholeConditionsLabel.text = "| " + model.weather.last!.desc
        self.wholeImageView.image = UIImage(named: model.weather.last!.icon)
        
        self.minTempLabel.text = String(Int(model.temp!.min)) + "°"
        self.maxTempLabel.text = String(Int(model.temp!.max)) + "°"
        
        
        self.morningImageView.image = UIImage(named: model.weather.last!.icon)
        self.morningTempLabel.text = String(Int(model.temp!.morn))
        self.morningFeelsLabel.text = String(Int(model.feelsLike!.morn))
        
        self.afternoonImageView.image = UIImage(named: model.weather.last!.icon)
        self.afternoonTempLabel.text = String(Int(model.temp!.day))
        self.afternoonFeelsLabel.text = String(Int(model.feelsLike!.day))
        
        self.eveningImageView.image = UIImage(named: model.weather.last!.icon)
        self.eveningTempLabel.text = String(Int(model.temp!.eve))
        self.eveningFeelsLabel.text = String(Int(model.feelsLike!.eve))
        
        self.nightImageView.image = UIImage(named: model.weather.last!.icon)
        self.nightTempLabel.text = String(Int(model.temp!.night))
        self.nightFeelsLabel.text = String(Int(model.feelsLike!.night))
    }
}
