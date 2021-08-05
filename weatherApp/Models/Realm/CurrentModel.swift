//
//  CurrentModel.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 5.8.2021.
//

import Foundation
import RealmSwift

class  CurrentModel: Object {
    @Persisted var dt: Int = 0
    @Persisted var temp: Double = 0.0
    @Persisted var feelsLike: Double = 0.0
    @Persisted var humidity: Int = 0
    @Persisted var uvi: Double = 0.0
    @Persisted var wind: String = ""
    @Persisted var weather: WeatherModel? = WeatherModel()
}
