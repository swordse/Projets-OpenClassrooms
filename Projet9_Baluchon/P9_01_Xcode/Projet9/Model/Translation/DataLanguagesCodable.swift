//
//  Language.swift
//  Projet9
//
//  Created by Raphaël Goupille on 31/08/2021.
//

import Foundation

// struct to decode JSON related to languages list
struct DataLanguagesCodable: Codable {
    
    let data: DataClass
    
    struct DataClass: Codable {
        let languages: [Language]
    }
    
    struct Language: Codable {
        let language, name: String
    }
    
}
