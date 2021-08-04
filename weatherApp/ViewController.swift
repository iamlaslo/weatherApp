//
//  ViewController.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import UIKit
import CoreLocation

class forecastCollectionView: UICollectionView {
    let id = ""
}

class dayForecastCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

class ViewController: UIViewController {
    
    
    
    private var locationManager: CLLocationManager?
    
    @IBOutlet weak var detailMainView: UIView!
    
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var uviLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    
    var object: OneCallObject?
    var model = OneCallModel()
    var daily = DailyModel()
    
    func reloadLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.stopUpdatingLocation()
        locationManager?.startUpdatingLocation()
        print("reloaded")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        print("vdl")
        
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
        
        model = RealmManager.shared.readModel()
        
        forecastCollectionView.reloadData()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        
        if let current = model.current {
            let todayDateInterval = TimeInterval(current.dt)
            let todayDate = Date(timeIntervalSince1970: todayDateInterval)
            dateLabel.text = dateFormatter.string(from: todayDate)
            
            tempLabel.text = String(Int(current.temp)) + "°"
            conditionsLabel.text = "| " + current.weather!.desc
            weatherImageView.image = UIImage(named: current.weather!.icon)
            
            humidityLabel.text = String(current.humidity) + "%"
            uviLabel.text = String(Int(current.uvi))
            windLabel.text = current.wind
        }
    }
    
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            let lat = String(format: "%.4f", loc.coordinate.latitude)
            let lon = String(format: "%.4f", loc.coordinate.longitude)
            
            NetworkManager.shared.getWeather(lat: lat, lon: lon) { [weak self] object in
                RealmManager.shared.writeModel(object: object)
                self?.object = object
                DispatchQueue.main.async {
                    self?.updateUI()
                    print("url")
                }
            }
            
            
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription, "Location Error")
    }
    
}


extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        daily = model.daily[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let dailyViewController = storyboard.instantiateViewController(identifier: "DailyVC") as? DailyViewController else { return }
        dailyViewController.model = daily
                
        show(dailyViewController, sender: nil)
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.daily.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayForecastCell", for: indexPath) as! dayForecastCell
        
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

