//
//  WindDir.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import Foundation

func getWindDirection() {
    let bound = 0...360

    enum windDirection {
        typealias RawValue = ClosedRange<Int>


        static let NNW = 327...360
        static let N = 0...1
        static let NNE = 2...33
        static let NE = 34...56
        static let ENE = 57...78
        static let E = 79...101
        static let ESE = 102...123
        static let SE = 124...146
        static let SSE = 147...168
        static let S = 169...191
        static let SSW = 192...213
        static let SW = 214...236
        static let WSW = 237...258
        static let W = 259...281
        static let WNW = 282...303
        static let NW = 303...326
    }

    func getWind(speed: Int, deg: Int) -> String {
//        let degDir = windDirection(rawValue: deg)
        switch deg {
        case 327...360:
            return "NNW"
        default:
            return "error"
        }

        return ""
    }
    
}
