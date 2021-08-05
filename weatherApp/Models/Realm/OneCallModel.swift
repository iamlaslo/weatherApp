//
//  OneCallModel.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 5.8.2021.
//

import Foundation
import RealmSwift

class OneCallModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var lat: Double = 0.0
    @Persisted var lon: Double = 0.0
    @Persisted var timezone: String = ""
    @Persisted var timezone_offset: Int = 0
    @Persisted var current: CurrentModel? = CurrentModel()
    @Persisted var daily: List<DailyModel> = List()
}
