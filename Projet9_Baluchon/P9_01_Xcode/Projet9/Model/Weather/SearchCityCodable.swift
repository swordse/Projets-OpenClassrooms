//
//  Weather.swift
//  Projet9
//
//  Created by Raphaël Goupille on 20/08/2021.
//

import Foundation

// Codable for the user search
struct SearchCityCodable: Codable {
    
    let weather: [Weather]
    let main: Temperature
    let name: String
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
}

struct Temperature: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}
