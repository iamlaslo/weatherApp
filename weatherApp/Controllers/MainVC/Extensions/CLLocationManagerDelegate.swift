//
//  ugu.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            let lat = String(format: "%.4f", loc.coordinate.latitude)
            let lon = String(format: "%.4f", loc.coordinate.longitude)
            
            NetworkManager.shared.getWeather(lat: lat, lon: lon) { [weak self] object in
                RealmManager.shared.writeModel(object: object)
                self?.object = object
                DispatchQueue.main.async {
                    updateUI(VC: self!, forecastCV: self!.forecastCollectionView)
                    print("url")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription, "Location Error")
    }
}
