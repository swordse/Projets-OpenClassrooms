//
//  Calculate.swift
//  Projet9
//
//  Created by Raphaël Goupille on 19/08/2021.
//

import Foundation


struct Convert {
    
    func calculation(amount: Double, currencyRate: Double, USDRate: Double) -> String {
        
        print("amount: \(amount), currencyRate: \(currencyRate), USDRate: \(USDRate)")
        
        let calculation = (amount / currencyRate)*USDRate
        
        let result = Formatter.numberToString(number: calculation)
        
        return result
    }
    
    
}
