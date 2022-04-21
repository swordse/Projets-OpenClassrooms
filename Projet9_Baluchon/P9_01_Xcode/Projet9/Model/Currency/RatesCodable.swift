//
//  Rates.swift
//  Projet9
//
//  Created by Raphaël Goupille on 18/08/2021.
//

import Foundation

// struct to decode JSON
struct RatesCodable: Codable {
    var date: String
    var rates: [String: Double]
}


