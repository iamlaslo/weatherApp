//
//  ViewController.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var todayDateLabel: UILabel!
    @IBOutlet weak var todayTempLabel: UILabel!
    @IBOutlet weak var todayConditionsLabel: UILabel!
    @IBOutlet weak var todayHumidityLabel: UILabel!
    @IBOutlet weak var todayUVLabel: UILabel!
    @IBOutlet weak var todayWindLabel: UILabel!
    
    private var locationManager: CLLocationManager?
    
    var object: OneCallObject?
    var model = OneCallModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        
        
        
    }
    
    func getDate(interval: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        let timeInterval = TimeInterval(interval)
        let date = Date(timeIntervalSince1970: timeInterval)
        return dateFormatter.string(from: date)
    }
    
    
    func updateUI() {
        todayDateLabel.text = getDate(interval: object?.current?.dt ?? 1)
        todayTempLabel.text = String(format: "%.2f", object?.current?.temp ?? 0.0)
        
        if let conditions = object?.current?.weather?.last {
//            debugPrint(conditions.main)
            todayConditionsLabel.text = conditions.main!
        }
        
        // TODO: USE THIS
        RealmManager.shared.writeModel(object: object)
        model = RealmManager.shared.readModel()
        print(model)
        
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            let lat = String(format: "%.4f", loc.coordinate.latitude)
            let lon = String(format: "%.4f", loc.coordinate.longitude)
            
            NetworkManager.shared.getWeather(lat: lat, lon: lon) { [weak self] object in
                self?.object = object
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            }
            
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

