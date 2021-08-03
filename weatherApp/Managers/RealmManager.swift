//
//  RealmManager.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}

class RealmManager {
    static let shared = RealmManager()
    
    private let realm: Realm!
    
    private init() {
        realm = try! Realm()
        debugPrint("RealmURL: ", realm.configuration.fileURL as Any)
    }
    
    var object: OneCallObject?
    
    func getCurrentWeatherModels(toObject: OneCallObject) -> WeatherModel {
        let model = WeatherModel()
        
        if let weatherObject = toObject.current?.weather?.last {  // there is only one weather model
            model.main = weatherObject.main!
            model.desc = weatherObject.description!
            model.icon = weatherObject.icon!
        }
        
        return model
    }
    
    func getDailyWeatherModels(toObject: OneCallObject, fromObject: Daily) -> WeatherModel {
        let model = WeatherModel()
        
        if let weatherObject = fromObject.weather?.last {  // there is only one weather model
            model.main = weatherObject.main!
            model.desc = weatherObject.description!
            model.icon = weatherObject.icon!
        }
        
        return model
    }
    
    func getCurrentModels(toObject: OneCallObject) -> CurrentModel {
        let model = CurrentModel()
        
        if let currentObject = toObject.current {
            model.dt = currentObject.dt!
            model.temp = currentObject.temp!
            model.feelsLike = currentObject.feels_like!
            model.humidity = currentObject.humidity!
            model.uvi = currentObject.uvi!
            model.wind = "TODO"
            model.weather = getCurrentWeatherModels(toObject: toObject)
        }
        
        return model
    }
    
    func getDailyModels(toObject: OneCallObject, index: Int) -> DailyModel {
        let model = DailyModel()
        
        if let currentObject = toObject.daily?[index] {
            model.dt = currentObject.dt!
            model.temp = getTempModel(toObject: toObject, fromObject: currentObject)
            model.feelsLike = getFeelsLikeModel(toObject: toObject, fromObject: currentObject)
            model.pressure = currentObject.pressure!
            model.humidity = currentObject.humidity!
            model.wind = "TODO"
            model.weather.append(getDailyWeatherModels(toObject: toObject, fromObject: currentObject))
            model.uvi = currentObject.uvi!
        }
        
        return model
    }
    
    func getTempModel(toObject: OneCallObject, fromObject: Daily) -> TempModel {
        let model = TempModel()
        
        if let currentObject = fromObject.temp {
            model.day = currentObject.day!
            model.min = currentObject.min!
            model.max = currentObject.max!
            model.night = currentObject.night!
            model.eve = currentObject.eve!
            model.morn = currentObject.morn!
        }
        
        return model
    }
    
    func getFeelsLikeModel(toObject: OneCallObject, fromObject: Daily) -> FeelsLikeModel {
        let model = FeelsLikeModel()
        
        if let currentObject = fromObject.feels_like {
            model.day = currentObject.day!
            model.night = currentObject.night!
            model.eve = currentObject.eve!
            model.morn = currentObject.morn!
        }
        
        return model
    }
    
    func getOneCallModel(toObject: OneCallObject?) -> OneCallModel {
        let model = OneCallModel()
        
        if let currentObject = toObject {
            model.lat = currentObject.lat!
            model.lon = currentObject.lon!
            model.timezone = currentObject.timezone!
            model.timezone_offset = currentObject.timezone_offset!
            model.current = getCurrentModels(toObject: toObject!)
            
            // TODO: Check how many days
            for i in 0..<3 {
                model.daily.append(getDailyModels(toObject: toObject!, index: i))
            }
        }
        
        return model
    }
    
    func writeModel(object: OneCallObject?) {
        do {
            try realm.safeWrite {
                var model = OneCallModel()
                model = getOneCallModel(toObject: object)
                realm.add(model, update: .modified)
            }
        }
        catch {
            print("WRITE ERROR")
            return
        }
    }
    
    func readModel() -> OneCallModel {
        guard let model = realm.objects(OneCallModel.self).first else { return OneCallModel() }
        return model
    }
    
}
