//
//  WeatherModel.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import Foundation
import RealmSwift

class WeatherModel: Object {
    @Persisted var main: String = ""
    @Persisted var desc: String = ""
    @Persisted var icon: String = ""
}
