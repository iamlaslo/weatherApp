//
//  ViewController+LocationManager.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import UIKit
import CoreLocation

class LocManager {
    static let shared = LocManager()
    private let manager = CLLocationManager()
    
    private init() { }
    
    func reloadLocation(withSelf: ViewController) {
        manager.delegate = withSelf
        manager.requestWhenInUseAuthorization()
        manager.stopUpdatingLocation()
        manager.startUpdatingLocation()
        print("updating started")
    }
}
