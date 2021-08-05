//
//  ViewController.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocManager.shared.reloadLocation(withSelf: self)
        
        updateUI(VC: self, forecastCV: forecastCollectionView)
    }
}
