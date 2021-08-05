//
//  agaa.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.daily.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayForecastCellID", for: indexPath) as! DayForecastCell
        
        let daily = model.daily[indexPath.item]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        let interval = TimeInterval(daily.dt)
        let date = Date(timeIntervalSince1970: interval)
        
        cell.imageView.image = UIImage(named: daily.weather.last!.icon)
        cell.tempLabel.text = String(Int(daily.temp!.max)) + "°"
        cell.dateLabel.text = dateFormatter.string(from: date)
        
        return cell
    }
}
