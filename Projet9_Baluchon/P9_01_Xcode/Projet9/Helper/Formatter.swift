//
//  Formatter.swift
//  Projet9
//
//  Created by Raphaël Goupille on 17/09/2021.
//

import Foundation

struct Formatter {
    
    static func temperatureToString (temp: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumIntegerDigits = 2
        formatter.maximumFractionDigits = 0
        let number = NSNumber(value: temp)
        let string = formatter.string(from: number) ?? "0"
        return string
    }
    
    static func numberToString (number: Double) -> String {
        let number = NSNumber(value: number)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        let result = formatter.string(from: number) ?? "0"
        
        return result
    }
    
}
