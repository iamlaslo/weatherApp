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
    private init() { }
    
    let appID = "0a23540fe3076492611d448886fefdb6"
    var baseURL = "https://api.openweathermap.org/data/2.5/onecall"
    
    private func buildParameters(lat: String, lon: String) -> [String:String]
    {
        return ["lat": lat,
                "lon": lon,
                "units": SettingsManager.shared.requestUnits.rawValue,
                "lang": SettingsManager.shared.requestLanguage.rawValue,
                "exclude": "hourly,minutely",
                "appid": appID]
    }
    
    func getWeather(lat: String, lon: String, unit: RequestUnitType = .unitMetric, lang: RequestLangType = .langEn, completion: @escaping (OneCallObject?) -> Void) {
        
        AF.request(baseURL, method: .get, parameters: buildParameters(lat: lat, lon: lon)).responseObject { (response: DataResponse<OneCallObject, AFError>) in
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
    
    func getIcon(icon: String, completion: @escaping (UIImage) -> Void) {
        
        AF.request("https://openweathermap.org/img/wn/\(icon)@2x.png").response { (response: DataResponse<Optional<Data>, AFError>) in
            if response.error == nil {
                let dataImg = Data(response.data!)
                let img = UIImage(data: dataImg)
                completion(img!)
            }
            else {
                completion(UIImage())
            }
            
        }
    }
    
}


