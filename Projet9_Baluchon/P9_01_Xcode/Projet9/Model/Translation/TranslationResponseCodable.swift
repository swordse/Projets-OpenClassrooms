//
//  Translation.swift
//  Projet9
//
//  Created by Raphaël Goupille on 29/08/2021.
//

import Foundation

// struct to decode the translation JSON obtained from google
struct TranslationResponseCodable: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
    let translatedText: String
}
