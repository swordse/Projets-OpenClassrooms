//
//  FakeCurrenciesResponseData.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 16/09/2021.
//

import Foundation


class FakeTranslationData {
    
    static let url: URL = URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyCi_MKsn6t-Yb2SUvchQ4lp59gjUL39LFg&q=pyramide&source=fr&target=en&format=text")!
    // fake response
    static let responseOK = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    // fake error
    class TranslationError: Error {}

    static let error = TranslationError()

    // fake data
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeCurrenciesResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let translationIncorrectData = "n'importe quoi".data(using: .utf8)!

}
