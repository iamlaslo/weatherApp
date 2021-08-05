//
//  GetDate.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 6.8.2021.
//

import Foundation

func getDate(interval: Int) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM YYYY"
    let timeInterval = TimeInterval(interval)
    let date = Date(timeIntervalSince1970: timeInterval)
    return dateFormatter.string(from: date)
}
