//
//  LanguagesList.swift
//  Projet9
//
//  Created by Raphaël Goupille on 17/09/2021.
//

import Foundation

// struct to save and retrieve the list of languages from userDefaults
struct LanguagesListUserDefaults {
    
    struct Key {
        static let key = "languagesList"
    }
    
    static func save (languagesList: DataLanguagesCodable) {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(languagesList) {
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: Key.key)
            print("Data have been saved")
        } else {
            print("failed to save")
        }
        
    }
    
    // retrieve data from userDefaults
    static func retrieve (completionHandler: (Result<DataLanguagesCodable, RetrieveDataError>) -> Void ) {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: Key.key) as? Data {
            do {
                let languagesList = try JSONDecoder().decode(DataLanguagesCodable.self, from: savedData)
                completionHandler(.success(languagesList))
                print("data has been retrieved from userdefaults")
            }
            catch {
                print("failed to retrieve data")
            }
        } else {
            print("no data to retrieve")
            completionHandler(.failure(.noData))
        }
    }
    
    
}
