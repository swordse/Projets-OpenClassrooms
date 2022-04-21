//
//  CityWeatherCodable.swift
//  Projet9
//
//  Created by Raphaël Goupille on 01/09/2021.
//

import Foundation

// codable for the two initials cities
struct CityIdCodable: Codable {
    let list : [List]
    
}

struct List: Codable {
    let weather: [Weather]
    let main: Temperature
    let name: String
}



