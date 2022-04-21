//
//  retrieveData.swift
//  Projet9
//
//  Created by Raphaël Goupille on 14/09/2021.
//

import Foundation

// struct to save and retrieve the list of languages from userDefaults
class CurrenciesListUserDefaults {
    
    // save data to userDefaults
    static func save(dataToSave: CurrencyCodable) {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(dataToSave)
        {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "currenciesList")
            print("data have been saved")
        } else {
            print("failed to save")
        }
        
    }
    
    // retrieve data from userDefaults
    static func retrieve (completionHandler: (Result<CurrencyCodable, RetrieveDataError>) -> Void ) {
        let defaults = UserDefaults.standard
        if let savedCurrencies = defaults.object(forKey: "currenciesList") as? (Data) {
            let jsonDecoder = JSONDecoder()
            do {
                let currenciesList = try jsonDecoder.decode(CurrencyCodable.self, from: savedCurrencies)
                completionHandler(.success(currenciesList))
            } catch {
                print("failed to retrieve data")
                
            }
        } else {
            print("no data to retrieve")
            completionHandler(.failure(.noData))
        }
    }
    
    
}
