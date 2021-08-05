//
//  hm.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit
import Foundation

func updateUI(VC: ViewController, forecastCV: UICollectionView) {
    
    VC.model = RealmManager.shared.readModel()
    
    forecastCV.reloadData()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM YYYY"
    
    if let current = VC.model.current {
        let todayDateInterval = TimeInterval(current.dt)
        let todayDate = Date(timeIntervalSince1970: todayDateInterval)
        VC.dateLabel.text = dateFormatter.string(from: todayDate)
        
        VC.tempLabel.text = String(Int(current.temp)) + "°"
        VC.conditionsLabel.text = "| " + current.weather!.desc
        VC.weatherImageView.image = UIImage(named: current.weather!.icon)
        
        VC.humidityLabel.text = String(current.humidity) + "%"
        VC.uviLabel.text = String(Int(current.uvi))
        VC.windLabel.text = current.wind
    }
}
