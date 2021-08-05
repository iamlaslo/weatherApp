//
//  WindDir.swift
//  weatherApp
//
//  Created by Vlad Kozlov on 3.8.2021.
//

import Foundation

func getWindString(windDirection: String, windSpeed: Int) -> String {
    
    let unit: String = getWindUnits()
    
    let output: String = "\(windDirection) \(windSpeed) \(unit)"
    
    return output
}

func getWindDirection(windDeg: Int) -> String {
    switch windDeg {
        case 0...11:
            return "N"
        case 12...33:
            return "NNE"
        case 34...56:
            return "NE"
        case 57...78:
            return "ENE"
        case 79...101:
            return "E"
        case 102...123:
            return "ESE"
        case 124...146:
            return "SE"
        case 147...168:
            return "SSE"
        case 169...191:
            return "S"
        case 192...213:
            return "SSW"
        case 214...236:
            return "SW"
        case 237...258:
            return "WSW"
        case 259...281:
            return "W"
        case 282...303:
            return "WNW"
        case 304...326:
            return "NW"
        case 327...348:
            return "NNW"
        case 349...360:
            return "N"
        default:
            return ""
    }
}
