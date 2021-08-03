//
//  NetworkManager.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkManager {
    static let shared = NetworkManager()
    private init() {
        
    }
    
    var url = "https://api.openweathermap.org/data/2.5/onecall?lat=46.4775&lon=30.7326&units=metric&lang=en&exclude=hourly,minutely&appid=0a23540fe3076492611d448886fefdb6"
    
    func getWeather(lat: String, lon: String, completion: @escaping (OneCallObject?) -> Void) {
        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&units=metric&lang=en&exclude=hourly,minutely&appid=0a23540fe3076492611d448886fefdb6").responseObject { (response: DataResponse<OneCallObject, AFError>) in
            if response.error == nil {
                do {
                    let obj = try response.result.get()
                    completion(obj)
                }
                catch {
                    completion(nil)
                }
            }
            else {
                completion(nil)
            }
        }
    }
    
    
}
