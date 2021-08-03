//
//  DailyModel.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import Foundation
import RealmSwift

class DailyModel: Object {
    @Persisted var dt: Int = 0
    @Persisted var temp: TempModel? = TempModel()
    @Persisted var feelsLike: FeelsLikeModel? = FeelsLikeModel()
    @Persisted var pressure: Int = 0
    @Persisted var humidity: Int = 0
    @Persisted var wind: String = ""
    @Persisted var weather: List<WeatherModel> = List()
    @Persisted var uvi: Double = 0.0
}
