//
//  FakeCurrenciesResponseData.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 16/09/2021.
//

import Foundation


class FakeLanguageData {
    static let url: URL = URL(string: "https://translation.googleapis.com/language/translate/v2/languages?key=AIzaSyCi_MKsn6t-Yb2SUvchQ4lp59gjUL39LFg&target=fr")!
    // fake response
    static let responseOK = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    // fake error
    class LanguageError: Error {}

    static let error = LanguageError()

    // fake data
    
    static var languageCorrectData: Data {
        let bundle = Bundle(for: FakeCurrenciesResponseData.self)
        let url = bundle.url(forResource: "Language", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let languageIncorrectData = "n'importe quoi".data(using: .utf8)!

}
