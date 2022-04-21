//
//  FakeCurrenciesResponseData.swift
//  Projet9Tests
//
//  Created by Raphaël Goupille on 16/09/2021.
//

import Foundation


class FakeCurrenciesResponseData {
    static let url: URL = URL(string: "http://data.fixer.io/api/symbols?access_key=0bc21a7070fd37a8cc7f9ab931e45b34")!
    // fake response
    static let responseOK = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    // fake error
    class CurrenciesError: Error {}

    static let error = CurrenciesError()

    // fake data
    
    static var currenciesCorrectData: Data {
        let bundle = Bundle(for: FakeCurrenciesResponseData.self)
        let url = bundle.url(forResource: "Currencies", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let currenciesIncorrectData = "n'importe quoi".data(using: .utf8)!

}
